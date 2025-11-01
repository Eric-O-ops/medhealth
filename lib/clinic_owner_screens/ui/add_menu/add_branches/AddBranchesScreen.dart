import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CommonCompliteScreen.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';

import 'AddBranchesModel.dart';

class AddBranchesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddBranchesScreenState();
}

class AddBranchesScreenState
    extends BaseScreen<AddBranchesScreen, AddBranchesModel> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildBody(BuildContext context, AddBranchesModel viewModel) {
    return
      Form(
          key: _formKey,
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Добавить филиал',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),

                SizedBox(height: 20),

                CustomTextFuild(
                  label: 'Адрес',
                  hintText: 'Введите адрес филиала',
                  validator: (value) =>
                  (value == null || value.isEmpty) ? 'Поле обязательно.' : null,
                  onChanged: (String? value) {
                    if (value != null) viewModel.address = value;
                  },
                ),

                SizedBox(height: 8),

                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: AppColors.blue,
                  child: const Text(
                    'Добавить',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommonCompleteScreen(title: "Заявка успешно отправлена!"),
                        ),
                      );
                        viewModel.postBranches();
                    }
                  },
                ),
              ]
          )
      );
  }

}