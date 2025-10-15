class Validator {
  // Регулярное выражение для проверки стандартного формата Email.
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Регулярное выражение для проверки, что строка содержит ТОЛЬКО буквы (кириллица, латиница) и пробелы.
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Zа-яА-Я\s]+$',
  );

  // Базовое регулярное выражение для номера телефона (позволяет цифры, скобки, тире, плюс)
  // Примечание: Для конкретного формата страны (например, +7...) потребуется более сложное RegExp.
  static final RegExp _phoneRegExp = RegExp(
    r'^[0-9\s()+-]+$',
  );

  /// Проверяет, соответствует ли строка стандартному формату Email.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите Email.';
    }
    if (!_emailRegExp.hasMatch(value)) {
      return 'Некорректный формат Email.';
    }
    return null; // Валидация пройдена
  }

  /// Проверяет, содержит ли строка ТОЛЬКО буквы и пробелы.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите имя.';
    }
    if (value.trim().length < 2) {
      return 'Имя должно быть длиннее 1 символа.';
    }
    if (!_nameRegExp.hasMatch(value)) {
      return 'Имя может содержать только буквы и пробелы.';
    }
    return null; // Валидация пройдена
  }

  /// Проверяет, содержит ли строка только допустимые символы для номера телефона.
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите номер телефона.';
    }
    // Удаляем все пробелы, чтобы проверить только символы
    String strippedValue = value.replaceAll(RegExp(r'\s+'), '');

    if (strippedValue.length < 5) {
      return 'Номер телефона слишком короткий.';
    }
    if (!_phoneRegExp.hasMatch(value)) {
      return 'Некорректные символы в номере телефона.';
    }
    return null; // Валидация пройдена
  }
}