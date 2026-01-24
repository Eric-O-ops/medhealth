// import 'package:flutter/cupertino.dart';
// import 'package:medhealth/clinic_list/model/ClinicDto.dart';
// import 'package:medhealth/clinic_list/model/SpecialtyDto.dart';
//
// class FilterModel extends ChangeNotifier {
//   // --- Данные для отображения ---
//
//   // Список всех доступных клиник (получен из getClinics())
//   List<ClinicDto> availableClinics = [
//     ClinicDto(idOwner: 101, name: 'Медик'),
//     ClinicDto(idOwner: 102, name: 'Фэстер'),
//     ClinicDto(idOwner: 103, name: 'ДГФГД'),
//   ];
//
//   // Список всех доступных специальностей
//   List<SpecialtyDto> availableSpecialties = [
//     SpecialtyDto(id: 1, name: 'Терапевт'),
//     SpecialtyDto(id: 2, name: 'Хирург'),
//     SpecialtyDto(id: 3, name: 'Кардиолог'),
//   ];
//
//   // --- Состояние выбранных чекбоксов ---
//
//   // Множество для хранения ID выбранных клиник
//   Set<int> _selectedClinicIds = {};
//   Set<int> get selectedClinicIds => _selectedClinicIds;
//
//   // Множество для хранения ID выбранных специальностей
//   Set<int> _selectedSpecialtyIds = {};
//   Set<int> get selectedSpecialtyIds => _selectedSpecialtyIds;
//
//   // Метод для переключения состояния чекбокса клиники
//   void toggleClinicSelection(int ownerId, bool isSelected) {
//     if (isSelected) {
//       _selectedClinicIds.add(ownerId);
//     } else {
//       _selectedClinicIds.remove(ownerId);
//     }
//     notifyListeners();
//   }
//
//   // Метод для переключения состояния чекбокса специальности
//   void toggleSpecialtySelection(int specialtyId, bool isSelected) {
//     if (isSelected) {
//       _selectedSpecialtyIds.add(specialtyId);
//     } else {
//       _selectedSpecialtyIds.remove(specialtyId);
//     }
//     notifyListeners();
//   }
//
//   // Метод для сброса всех фильтров
//   void clearFilters() {
//     _selectedClinicIds.clear();
//     _selectedSpecialtyIds.clear();
//     notifyListeners();
//   }
// }