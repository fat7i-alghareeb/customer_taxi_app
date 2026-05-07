import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_token_model.freezed.dart';
part 'auth_session_token_model.g.dart';

@freezed
abstract class AuthSessionTokenModel with _$AuthSessionTokenModel {
  const factory AuthSessionTokenModel({required String sessionToken}) =
      _AuthSessionTokenModel;

  factory AuthSessionTokenModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionTokenModelFromJson(json);
}
