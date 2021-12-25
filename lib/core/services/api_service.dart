import 'dart:convert';
import 'package:http/http.dart' as http;
import '/core/constants/app_constants.dart';
import '/core/models/response_model.dart';
import '/core/models/user_model.dart';
import '/core/states/request_state.dart';
import '/locator.dart';

class ApiService {
  
  final requestState = locator<RequestState>();
  ResponseModel response = ResponseModel();



  //  make a request to get new password
  Future<ResponseModel> forgetPassword(String mail) async {
    response = null;
    String body = '{"email" : "$mail"}';
    try {

      requestState.makeStateBusy();
      final request = await http.post(Uri.parse(AppConstants.API_URL+AppConstants.FORGET_PASSWORD+"/$mail"),headers: AppConstants.HEADERS,body: body);
      if(request.statusCode == 201) {
        response = ResponseModel.fromJson(json.decode(request.body));
      } else {
        response = ResponseModel.fromJson(json.decode(request.body));
      }
    } catch (e) {
      return ResponseModel();
    }

    requestState.makeStateNormal();

    return response;
  }

}
