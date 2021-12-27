import 'package:test/test.dart';
import 'package:todo_app/utils/index.export.dart';

void main() {
  group('String utils ->', () {
    test('String null must  return true', () {
      expect(StringUtils.checkStringIsEmptyOrNull(null), true);
    });

    test('String empty must return true', () {
      expect(StringUtils.checkStringIsEmptyOrNull(''), true);
    });

    test('String with all space must return true', () {
      expect(StringUtils.checkStringIsEmptyOrNull('      '), true);
    });

    test('String is valid must return false', () {
      expect(StringUtils.checkStringIsEmptyOrNull("valid string"), false);
    });
  });
}
