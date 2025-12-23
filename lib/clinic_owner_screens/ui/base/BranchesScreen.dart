//
// import 'package:flutter/cupertino.dart';
// import 'package:medhealth/clinic_owner_screens/ui/view/BranchesBottomSheet.dart';
// import 'package:medhealth/clinic_owner_screens/ui/view/BranchesCard.dart'
//     show BranchesCard;
// import 'package:medhealth/common/view/CommonErrorScreen.dart';
// import 'package:medhealth/common/view/CommonLoadingScreen.dart';
//
// import '../../../common/BaseScreen.dart';
// import '../../../styles/app_colors.dart';
// import 'BranchesModel.dart';
//
// class BranchesScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => BranchesScreenState();
// }
//
// class BranchesScreenState extends BaseScreen<BranchesScreen, BranchesModel> {
//   @override
//   Widget buildBody(BuildContext context, BranchesModel viewModel) {
//     return Builder(
//       builder: (context) {
//         if (viewModel.isLoading) {
//           return CommonLoadingScreen();
//         } else if (viewModel.isError) {
//           return CommonErrorScreen();
//         } else {
//           return Column(
//             children: [
//               SizedBox(height: 45),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Филиалы',
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
//                   ),
//
//                   Text(
//                     viewModel.branches[0].nameClinic,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w900,
//                       color: AppColors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 20),
//
//               Row(
//                 children: [
//                   Text(
//                     'Кол-во: ',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                   ),
//                   Text(
//                     viewModel.branches.length.toString(),
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w900,
//                       color: AppColors.blue,
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: 26),
//
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: viewModel.branches.length,
//                   itemBuilder: (context, index) {
//                     final branch = viewModel.branches[index];
//                     return BranchesCard(
//                       model: branch,
//                       onEdit: (int id) {
//                         openModalBottomSheet(context, viewModel, id);
//                       },
//                       onRemove: (int id) {
//                         viewModel.removeBranches(id);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
