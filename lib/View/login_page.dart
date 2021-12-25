import 'package:flutter/material.dart';
import 'package:internal/View/forget_password.dart';
import '/core/mixin/form_validator.dart';
import '/core/models/user_model.dart';
import '/core/reusable_widgets/message_dialog.dart';
import '/core/reusable_widgets/outlined_button.dart';
import '/core/reusable_widgets/show_dialog.dart';
import '/core/services/api_service.dart';
import '/core/states/request_state.dart';
import '/locator.dart';
import '/shared/styles.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormValidation {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  double screenWidth;
  double screenHeight;

  final apiService = locator<ApiService>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appbar,
        body: Consumer<RequestState>(
          builder: (context, requestState, widget) => requestState.isFetching
              ? Center(child: CircularProgressIndicator())
              : Container(
            padding: const EdgeInsets.all(100),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                    'assets/images/Icon.png',
                    width: 80,
                    height: 80,
                    fit:BoxFit.contain
                ),
                const SizedBox(height: 15),
                forgetPassword(requestState),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get appbar => AppBar(
    title: Text(
      "Password Reset with email",
      style: Styles.instance.snackbarTitleStyle,
    ),
    backgroundColor: Color(0xFFFF8000),
    centerTitle: true,
  );

  Widget forgetPassword(RequestState requestState) => DefaultOutlineButton(
    onPressed: () {
      CustomShowDialog.instance.showFormDialog(
          context,
          requestState,
          ForgetPassword(
              screenHeight: screenHeight,
              emailController: _emailController,
              formKey: _formKey), acceptButton: () async {
        if (_formKey.currentState.validate()) {

          _formKey.currentState.save();
          Future.delayed(Duration.zero, () async {
            await Future.delayed(const Duration(milliseconds: 100));
            Navigator.pushNamed(context, "/login");
          });
          //Navigator.of(context).pop();
          await apiService
              .forgetPassword(_emailController.text)
              .then((value) {
            showSnackbarMessage(value.message, value.ok ? true : false);
            _emailController.clear();
          });
        }
      });
    },
    buttonLabel: 'Reset with mail',
    height: screenHeight * 0.09,
    width: double.infinity,
    textStyle: Styles.instance.defaultButtonTextStyle,
    icon: Icon(
      Icons.alternate_email,
      color: Styles.instance.defaultPrefixIconColor,
      size: Styles.instance.defaultPrefixIconSize,
    ),
  );

  showSnackbarMessage(String message, bool isSuccess) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: CustomMessageDialog.instance.showMessageDialog(
          context: context, isSuccess: isSuccess, message: message),
      duration: Duration(milliseconds: Styles.instance.snackbarMessageDuration),
    ));
  }
}
