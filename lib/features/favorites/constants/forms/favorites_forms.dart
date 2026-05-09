import 'package:customertaxi/common/imports/imports.dart';

abstract class FavoritesForms {
  static const String searchField = 'search';

  static FormGroup formGroup() => FormGroup({
        searchField: FormControl<String>(value: ''),
      });
}
