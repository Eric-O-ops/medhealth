// // filter_screen.dart
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'FilterModel.dart';
//
// class FilterScreen extends StatelessWidget {
//   const FilterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Получаем доступ к модели состояния через Provider
//     final model = context.watch<FilterModel>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Фильтры'),
//         actions: [
//           TextButton(
//             onPressed: model.clearFilters,
//             child: const Text('Сбросить', style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // --- Блок фильтрации по клиникам ---
//               Text(
//                 'Выбор клиник',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const Divider(),
//
//               // Список клиник
//               ...model.availableClinics.map((clinic) {
//                 final isSelected = model.selectedClinicIds.contains(clinic.idOwner);
//                 return CheckboxListTile(
//                   title: Text(clinic.name),
//                   value: isSelected,
//                   onChanged: (bool? newValue) {
//                     model.toggleClinicSelection(clinic.idOwner, newValue ?? false);
//                   },
//                 );
//               }).toList(),
//
//               const SizedBox(height: 30),
//
//               // --- Блок фильтрации по специальностям ---
//               Text(
//                 'Выбор специальностей',
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const Divider(),
//
//               // Список специальностей
//               ...model.availableSpecialties.map((specialty) {
//                 final isSelected = model.selectedSpecialtyIds.contains(specialty.id);
//                 return CheckboxListTile(
//                   title: Text(specialty.name),
//                   value: isSelected,
//                   onChanged: (bool? newValue) {
//                     model.toggleSpecialtySelection(specialty.id, newValue ?? false);
//                   },
//                 );
//               }).toList(),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             minimumSize: const Size(double.infinity, 50), // Делаем кнопку широкой
//           ),
//           onPressed: () {
//             // Здесь вы можете передать выбранные фильтры обратно на предыдущий экран
//             // или вызвать метод загрузки данных с учетом этих фильтров.
//
//             // Пример: вывод выбранных фильтров
//             print('Selected Clinics: ${model.selectedClinicIds}');
//             print('Selected Specialties: ${model.selectedSpecialtyIds}');
//
//             Navigator.pop(context); // Закрываем экран фильтров
//           },
//           child: const Text('Применить фильтры', style: TextStyle(fontSize: 18)),
//         ),
//       ),
//     );
//   }
// }