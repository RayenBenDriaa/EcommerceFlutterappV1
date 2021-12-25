import 'package:flutter/material.dart';

class Panier extends StatefulWidget {
  Panier({Key key}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text(
        "Page Panier",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          color: Colors.red,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
