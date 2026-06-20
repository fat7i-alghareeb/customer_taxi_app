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

  Future<void> deleteAccount() {
    return rethrowAsAppException(() async {
      printY('[ProfileRemoteDataSource] deleteAccount');
      await _dio.delete<dynamic>(ApiEndpoints.deleteAccount);
    });
  }

  Future<ProfileModel> updateProfile(UpdateUserProfileRequest param) {
    return rethrowAsAppException(() async {
      printY(
        '[ProfileRemoteDataSource] updateProfile name="${param.name}" hasPhoto=${param.photo != null}',
      );

      final formData = FormData();
      if (param.name != null) {
        formData.fields.add(MapEntry('Name', param.name!));
      }
      if (param.email != null) {
        formData.fields.add(MapEntry('Email', param.email!));
      }
      // Home address fields are only sent when present; omitting all three lets
      // the backend clear a previously-saved address.
      if (param.homeAddressLabel != null) {
        formData.fields.add(
          MapEntry('HomeAddressLabel', param.homeAddressLabel!),
        );
      }
      if (param.homeAddressLatitude != null) {
        formData.fields.add(
          MapEntry(
            'HomeAddressLatitude',
            param.homeAddressLatitude!.toString(),
          ),
        );
      }
      if (param.homeAddressLongitude != null) {
        formData.fields.add(
          MapEntry(
            'HomeAddressLongitude',
            param.homeAddressLongitude!.toString(),
          ),
        );
      }
      if (param.photo != null) {
        formData.files.add(
          MapEntry('Photo', await MultipartFile.fromFile(param.photo!.path)),
        );
      }

      final res = await _dio.post<dynamic>(
        ApiEndpoints.currentUser,
        data: formData,
      );
      return ProfileModel.fromJson(res.data as Map<String, dynamic>);
    });
  }
}
