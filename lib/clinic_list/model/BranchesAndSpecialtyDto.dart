const SPECIALIZATION_CHOICES = <List<String>>[
  ['therapist', 'Терапевт'],
  ['surgeon', 'Хирург'],
  ['pediatrician', 'Педиатр'],
  ['cardiologist', 'Кардиолог'],
  ['neurologist', 'Невролог'],
  ['dentist', 'Стоматолог'],
  ['ophthalmologist', 'Офтальмолог'],
  ['dermatologist', 'Дерматолог'],
  ['psychiatrist', 'Психиатр'],
  ['other', 'Другое'],
];

final Map<String, String> specializationTranslationMap = {
  for (var list in SPECIALIZATION_CHOICES) list[0]: list[1],
};

class BranchesAndSpecialtyDto {
  final String branchName;
  final List<String> specializations;

  BranchesAndSpecialtyDto(this.branchName, this.specializations);

  factory BranchesAndSpecialtyDto.fromJson(Map<String, dynamic> json) {
    final List rawSpecializations = json['found_specializations'] as List;
    final List<String> translatedSpecialties = rawSpecializations.map((item) {
      final String englishName = item.toString();
      return specializationTranslationMap[englishName] ?? englishName;
    }).toList();

    return BranchesAndSpecialtyDto(
      json['address'] as String,
      translatedSpecialties,
    );
  }
}
