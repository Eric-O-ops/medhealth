import 'package:flutter/cupertino.dart';
import 'package:medhealth/common/BaseScreen.dart';

import 'AddManagerModel.dart';

class AddManagerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddManageScreenState();
  }

}

class AddManageScreenState extends BaseScreen<AddManagerScreen, AddManagerModel> {

  @override
  Widget buildBody(BuildContext context, AddManagerModel viewModel) {
    return Column(children: [],);
  }

}
