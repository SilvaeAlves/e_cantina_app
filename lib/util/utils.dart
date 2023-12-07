import 'package:uuid/uuid.dart';

class Utils {
  static int transformTo6Digits(int inputNumber) {
    var uuid = const Uuid();
    String uniqueId = uuid.v1();

    String numericPart = uniqueId.replaceAll(RegExp(r'[^0-9]'), '');

    String resultString = numericPart.substring(0, 6);

    return int.parse(resultString);
  }
}
