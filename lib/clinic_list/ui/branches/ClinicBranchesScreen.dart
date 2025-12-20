import 'package:flutter/cupertino.dart';
import 'package:medhealth/clinic_list/ui/view/BranchesFilterCard.dart';
import 'package:medhealth/common/BaseScreen.dart';
import 'package:medhealth/common/view/CommonErrorScreen.dart'
    show CommonErrorScreen;
import 'package:medhealth/common/view/CommonLoadingScreen.dart';

import 'ClinicBranchesModel.dart';

class ClinicBranchesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClinicBranchesScreenState();
  }
}

class ClinicBranchesScreenState
    extends BaseScreen<ClinicBranchesScreen, ClinicBranchesModel> {
  @override
  Widget buildBody(BuildContext context, ClinicBranchesModel viewModel) {
    return Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return CommonLoadingScreen();
          } else if (viewModel.isError) {
            return CommonErrorScreen();
          } else {
            return Column(
              children: [
                SizedBox(height: 45),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Филиалы клиники: \n${viewModel.nameClinic}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.listBranches.length,
                    itemBuilder: (context, index) {
                      final branch = viewModel.listBranches[index];
                      return BranchesFilterCard(
                        branch.branchName,
                        branch.specializations
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}