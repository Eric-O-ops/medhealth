// import 'package:flutter/cupertino.dart';
// import 'package:medhealth/clinic_list/ui/branches/ClinicBranchesModel.dart';
// import 'package:medhealth/clinic_list/ui/view/ClinikCard.dart';
// import 'package:medhealth/common/BaseScreen.dart';
// import 'package:medhealth/common/view/CommonErrorScreen.dart';
// import 'package:medhealth/common/view/CommonLoadingScreen.dart';
//
// import 'ClinicListModel.dart';
// import 'branches/ClinicBranchesScreen.dart';
//
// class ClinicListScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ClinicListScreenState();
//   }
// }
//
// class ClinicListScreenState extends BaseScreen<ClinicListScreen, ClinicListModel> {
//   @override
//   Widget buildBody(BuildContext context, viewModel) {
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
//                     'Клиники',
//                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
//                   ),
//
//                 ],
//               ),
//
//               SizedBox(height: 20),
//
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: viewModel.clinics.length,
//                   itemBuilder: (context, index) {
//                     final clinic = viewModel.clinics[index];
//                     return ClinicCard(
//                         name: clinic.name,
//                         onTap: () {
//                           navigateTo(
//                               screen: ClinicBranchesScreen(),
//                               createModel:() => ClinicBranchesModel(
//                                   clinic.idOwner,
//                                   clinic.name
//                               )
//                           );
//                         }
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
//
// }