import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_login_response_model.freezed.dart';
part 'auth_login_response_model.g.dart';

@freezed
abstract class AuthLoginResponseModel with _$AuthLoginResponseModel {
  const factory AuthLoginResponseModel({
    required String accessToken,
    required String refreshToken,
    required AuthUserModel user,
  }) = _AuthLoginResponseModel;

  factory AuthLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginResponseModelFromJson(json);
}

@freezed
abstract class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    String? name,
    required String phone,
    String? profilePhotoUrl,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
