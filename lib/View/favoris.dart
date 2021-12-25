import 'package:flutter/material.dart';

class Favoris extends StatefulWidget {
  Favoris({Key key}) : super(key: key);

  @override
  _FavorisState createState() => _FavorisState();
}

class _FavorisState extends State<Favoris> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text(
        'Page Favoris',
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
