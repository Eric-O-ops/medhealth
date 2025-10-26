class Validator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  // Разрешает буквы (латиница/кириллица) и пробелы
  static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Zа-яА-Я\s]+$',
  );
  // Базовая проверка телефона (цифры, пробелы, скобки, тире, плюс)
  static final RegExp _phoneRegExp = RegExp(
    r'^[0-9\s()+-]+$',
  );

  // Регулярное выражение для пароля:
// ^                 Начало строки
// (?=.*[a-z])       Должна содержать хотя бы одну строчную букву
// (?=.*[A-Z])       Должна содержать хотя бы одну заглавную букву
// (?=.*[0-9])       Должна содержать хотя бы одну цифру
// (?=.*[!@#\$%^&*]) Должна содержать хотя бы один спецсимвол из набора
// .{8,}             Должна быть длиной не менее 8 символов
// $                 Конец строки
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*()-_+=])(?=.{8,})',
  );

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Пожалуйста, введите Email.';
    if (!_emailRegExp.hasMatch(value)) return 'Некорректный формат Email.';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Пожалуйста, введите имя.';
    if (value.trim().length < 2) return 'Имя должно быть длиннее 1 символа.';
    if (!_nameRegExp.hasMatch(value)) return 'Имя может содержать только буквы и пробелы.';
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'Пожалуйста, введите номер телефона.';
    String strippedValue = value.replaceAll(RegExp(r'\s+'), '');
    if (strippedValue.length < 5) return 'Номер телефона слишком короткий.';
    if (!_phoneRegExp.hasMatch(value)) return 'Некорректные символы в номере телефона.';
    return null;
  }

  /// Проверяет, соответствует ли пароль минимальным требованиям безопасности.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пожалуйста, введите пароль.';
    }

    if (value.length < 8) {
      return 'Пароль должен содержать не менее 8 символов.';
    }

    if (!_passwordRegExp.hasMatch(value)) {
      // Более детальное сообщение об ошибке
      return 'Пароль должен содержать: 8+ символов, заглавную и строчную букву, цифру и спецсимвол.';
    }

    return null; // Валидация пройдена
  }

  /// Проверяет, совпадают ли первый и второй пароли.
  static String? validateRepeatPassword(String? first, String? second) {
    if (second == null || second.isEmpty) {
      return 'Пожалуйста, повторите пароль.';
    }

    // Сначала проверяем, что основной пароль не пуст
    if (first == null || first.isEmpty) {
      return 'Основной пароль не введен.';
    }

    // Проверяем на совпадение
    if (first != second) {
      return 'Пароли не совпадают.';
    }

    return null; // Валидация пройдена
  }

}