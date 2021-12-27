import 'package:test/test.dart';
import 'package:todo_app/utils/uuid.utils.dart';

void main() {
  group('UUID utils ->', () {
    test('UUID must be length >0', () {
      String id = Uuid().generateV4();
      bool actual = id.isNotEmpty;
      expect(actual, true);
    });

    test('UUID must be length  = 36', () {
      String id = Uuid().generateV4();
      bool actual = id.length == 36;
      expect(actual, true);
    });

    test('UUID must be format V4', () {
      String id = Uuid().generateV4();
      RegExp regExp = RegExp(
          "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}");
      bool actual = regExp.hasMatch(id);
      expect(actual, true);
    });
  });
}
