import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BaseScreenModel.dart';

abstract class BaseScreen<S extends StatefulWidget, VM extends BaseScreenModel>
    extends State<S> {
  Widget buildBody(BuildContext context, VM viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VM>(
        builder: (context, viewModel, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildBody(context, viewModel),
            ),
          );
        },
      ),
    );
  }
}
