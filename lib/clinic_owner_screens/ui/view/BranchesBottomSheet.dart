import 'package:flutter/material.dart';
import 'package:medhealth/clinic_owner_screens/ui/base/BranchesModel.dart';
import 'package:medhealth/common/view/CustomTextField.dart';
import 'package:medhealth/styles/app_colors.dart';

void openModalBottomSheet(BuildContext context, BranchesModel viewModel, int id) {
  final formKey = GlobalKey<FormState>();
  String address = '';

  showModalBottomSheet(
    context: context,
    //isDismissible: false,
    //enableDrag: false,
    builder: (BuildContext context) {
      return Form(
          key: formKey,
          child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFuild(
                label: 'Адрес',
                hintText: 'Введите адрес филиала',
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Поле обязательно.'
                    : null,
                onChanged: (String? value) {
                  if (value != null) address = value;
                },
              ),

              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: AppColors.blue,
                child: const Text(
                  'Сохранить',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    viewModel.updateBranchesAddress(id,address);
                  }
                },
              ),
            ],
          ),
        ),
      ));
    },
  );
}
