import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/core/validators/form_validators.dart';

void main() {
  group('FormValidators', () {
    group('email', () {
      test('valid email returns null', () => expect(FormValidators.email('test@example.com'), isNull));
      test('invalid email returns error', () => expect(FormValidators.email('not-an-email'), isNotNull));
      test('empty email returns error', () => expect(FormValidators.email(''), isNotNull));
    });
    group('password', () {
      test('valid password returns null', () => expect(FormValidators.password('Str0ngPass'), isNull));
      test('short password returns error', () => expect(FormValidators.password('abc'), isNotNull));
      test('no uppercase returns error', () => expect(FormValidators.password('alllowercase1'), isNotNull));
      test('no number returns error', () => expect(FormValidators.password('AllUpperNoNum'), isNotNull));
    });
    group('pin', () {
      test('valid 6-digit PIN returns null', () => expect(FormValidators.pin('123456'), isNull));
      test('short PIN returns error', () => expect(FormValidators.pin('123'), isNotNull));
      test('non-numeric PIN returns error', () => expect(FormValidators.pin('12345a'), isNotNull));
    });
    group('name', () {
      test('valid name returns null', () => expect(FormValidators.name('John Doe'), isNull));
      test('single char name returns error', () => expect(FormValidators.name('J'), isNotNull));
      test('empty name returns error', () => expect(FormValidators.name(''), isNotNull));
    });
  });
}
