import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BaseScreenModel.dart';

abstract class BaseScreen<S extends StatefulWidget, VM extends BaseScreenModel>
    extends State<S> {
  Widget buildBody(BuildContext context, VM viewModel);

  Future<R?> navigateTo<T extends BaseScreenModel, R>({
    required Widget screen,
    required T Function() createModel,
  }) {
    final model = createModel();
    model.initialize();

    return Navigator.of(context).push<R>(
      MaterialPageRoute(
        builder: (context) =>
            ChangeNotifierProvider.value(value: model, child: screen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<VM>(
        builder: (context, viewModel, child) {
          return Center(
            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildBody(context, viewModel),
                  //todo need add column widget
                ),
            )
          );
        },
      ),
    );
  }
}
