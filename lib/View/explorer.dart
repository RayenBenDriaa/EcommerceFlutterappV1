import 'package:flutter/material.dart';

class Explorer extends StatefulWidget {
  Explorer({Key key}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text(
        "Page Explorer",
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
