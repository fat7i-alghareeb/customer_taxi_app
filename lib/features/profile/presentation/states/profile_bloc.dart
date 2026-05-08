import 'dart:io';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:customertaxi/features/profile/data/params/profile_params.dart';
import 'package:customertaxi/features/profile/domain/entities/profile_entity.dart';
import 'package:customertaxi/features/profile/domain/facade/profile_facade.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._facade) : super(const ProfileState()) {
    on<_Started>(_onStarted);
    on<_NameSaved>(_onNameSaved);
    on<_PhotoSelected>(_onPhotoSelected);
    on<_SaveRequested>(_onSaveRequested);
  }

  final ProfileFacade _facade;

  Future<void> _onStarted(_Started event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(loadStatus: const BlocStatus.loading()));
    final Result<ProfileEntity> result = await _facade.getCurrentUser();
    result.when(
      success: (user) {
        printG('[ProfileBloc] started loaded id=${user.id}');
        emit(state.copyWith(
          loadStatus: BlocStatus<ProfileEntity>.success(user),
          currentUser: user,
          pendingName: user.name ?? '',
        ));
      },
      failure: (message) {
        printY('[ProfileBloc] started failed=$message');
        emit(state.copyWith(loadStatus: BlocStatus<ProfileEntity>.failure(message)));
      },
    );
  }

  void _onNameSaved(_NameSaved event, Emitter<ProfileState> emit) {
    emit(state.copyWith(pendingName: event.name));
  }

  void _onPhotoSelected(_PhotoSelected event, Emitter<ProfileState> emit) {
    emit(state.copyWith(pendingPhoto: event.photo));
  }

  Future<void> _onSaveRequested(
    _SaveRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final name = state.pendingName.trim();
    if (name.isEmpty && state.pendingPhoto == null) return;

    emit(state.copyWith(saveStatus: const BlocStatus.loading()));

    final Result<ProfileEntity> result = await _facade.updateProfile(
      UpdateUserProfileRequest(
        name: name.isEmpty ? null : name,
        photo: state.pendingPhoto,
      ),
    );

    result.when(
      success: (user) {
        printG('[ProfileBloc] save success id=${user.id}');
        emit(state.copyWith(
          saveStatus: BlocStatus<ProfileEntity>.success(user),
          currentUser: user,
          pendingPhoto: null,
        ));
      },
      failure: (message) {
        printY('[ProfileBloc] save failed=$message');
        emit(state.copyWith(saveStatus: BlocStatus<ProfileEntity>.failure(message)));
      },
    );
  }
}
