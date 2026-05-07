import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';

import '../../../../core/error/global_error_handler.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/profile_model.dart';
import '../params/profile_params.dart';

@lazySingleton
class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<ProfileModel> getCurrentUser() {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] getCurrentUser');
      final res = await _dio.get<dynamic>(ApiEndpoints.currentUser);
      return ProfileModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<ProfileModel> updateProfile(UpdateProfileParam param) {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] updateProfile name="${param.name}"');
      final res = await _dio.patch<dynamic>(
        ApiEndpoints.currentUser,
        data: param.toJson(),
      );
      return ProfileModel.fromJson(res.data as Map<String, dynamic>);
    });
  }

  Future<String> uploadPhoto(UpdateProfilePhotoParam param) {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] uploadPhoto path="${param.photo.path}"');
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(param.photo.path),
      });
      final res = await _dio.post<dynamic>(
        ApiEndpoints.uploadPhoto,
        data: formData,
      );
      return (res.data as Map<String, dynamic>)['photoUrl'] as String;
    });
  }
}
