import 'package:flutter/material.dart';

abstract class BaseScreen<S extends StatefulWidget> extends State<S> {
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildBody(context),
        ),
      )
    );
  }
}
