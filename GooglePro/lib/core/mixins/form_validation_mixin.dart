import '../validators/form_validators.dart';

mixin FormValidationMixin {
  bool validateEmail(String email) => FormValidators.email(email) == null;
  bool validatePassword(String password) => FormValidators.password(password) == null;
  bool validatePin(String pin) => FormValidators.pin(pin) == null;
  bool validateName(String name) => FormValidators.name(name) == null;
  bool validatePhone(String phone) => FormValidators.phone(phone) == null;
  bool validateRequired(String? value) => value != null && value.trim().isNotEmpty;
}
