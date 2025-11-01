import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/clinic_owner_screens/model/BranchesDto.dart'
    show BranchDto;
import 'package:medhealth/styles/app_colors.dart';

Widget BranchesCard({
  required BranchDto model,
  required Function(int id) onEdit,
  required Function(int id) onRemove,
}) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),

          Row(
            children: [
              Text(
                'Филиал: ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),

              Text(
                model.address,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  onEdit(model.id);
                },
                icon: Image.asset('assets/images/edit_icon.png'),
              ),

              IconButton(
                onPressed: () {
                  onRemove(model.id);
                },
                icon: Image.asset('assets/images/remove_icon.png'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
