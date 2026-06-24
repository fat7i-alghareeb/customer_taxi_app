import 'package:flutter_test/flutter_test.dart';
import 'package:customertaxi/core/services/media/media_picker_service.dart';

void main() {
  test('cancelled media selection is not reported as a failure', () {
    const result = MediaPickerResult.cancelled();

    expect(result.files, isEmpty);
    expect(result.failure, isNull);
    expect(result.isSuccess, isFalse);
  });
}
