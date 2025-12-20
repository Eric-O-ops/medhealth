import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medhealth/clinic_owner_screens/model/BranchesDto.dart'
    show BranchDto;
import 'package:medhealth/styles/app_colors.dart';

Widget ClinicCard({
  required String name,
  required VoidCallback onTap,
}) {
  return Card(
      color: AppColors.veryLightBlue,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [

              SvgPicture.asset(
                'assets/images/user_plus.svg',
                width: 38,
                height: 38,
                color: AppColors.black,
              ),

              SizedBox(width: 20),

              Text(
                name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ));
  }
