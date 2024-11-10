import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roboti_app/app/language_constant.dart';
import 'package:roboti_app/common/error_messages/error_messages.dart';
import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/presentation/auth/model/login_response.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/base_event.dart';
import 'package:roboti_app/presentation/home/view_model/bloc/home_bloc.dart';
import 'package:roboti_app/presentation/profile/ui/screen/profile_screen.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_bloc.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_events.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_states.dart';
import 'package:roboti_app/presentation/profile/view_model/repo/profile_repo.dart';
import 'package:roboti_app/service/di.dart';
import 'package:roboti_app/service/remote/network_api_services.dart';
import 'package:roboti_app/utils/extensions/route_extension.dart';
import 'package:roboti_app/utils/shared_pref_manager/shared_pref.dart';

class ProfileEventsHandler {
  final ProfileRepo _repo = ProfileRepo();
  FutureOr<void> profileHandler(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (event is GotoEditProfileEvent) {
      _gotoEditProfileScreen(event, emit);
    } else if (event is UpdateProfileEvent) {
      await _updateProfileEvent(event, emit);
      // } else if (event is GetUserProfileEvent) {
      //   await _getUserProfile(event, emit);
    }
  }

  // Future<void> _getUserProfile(
  //   GetUserProfileEvent event,
  //   Emitter<ProfileState> emit,
  // ) async {
  //   // Get user profile
  //   LoginResponse response = await _repo.getUserProfile();

  //   homeBloc.loginResponse.copy(response);

  //   await getIt<SharedPrefsManager>().saveUser(homeBloc.loginResponse);
  // }

  void _gotoEditProfileScreen(
    GotoEditProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    // event.context.pop();
    event.context.pushNamed(ProfileScreen.route);
  }

  Future<void> _updateProfileEvent(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    primaryFocus!.unfocus();
    LoginResponse loginResponse = homeBloc.loginResponse;
    if (event.name.trim().toLowerCase() ==
            loginResponse.name.toString().trim().toLowerCase() &&
        event.country.toLowerCase() ==
            loginResponse.country.toString().toLowerCase() &&
        event.file == null) {
      return ErrorMessages.display(lcGlobal.nochangesInProfile);
    }

    emit(UpdateProfileLoadingState());

    String? imageUrl;
    if (profileBloc.image != null) {
      imageUrl = await __uploadProfileImage(event, emit);

      if (imageUrl == null) {
        return emit(UpdateProfileErrorState());
      } else {
        emit(UpdateProfileSuccessState());
      }
      profileBloc.image = null;
    }

    // Update Profile
    LoginResponse response = await _repo.updateProfile(
      image: imageUrl,
      name: event.name.trim(),
      country: event.country,
    );

    if (response.email == null) {
      ErrorMessages.display(response.message);
      return emit(UpdateProfileErrorState());
    }

    homeBloc.loginResponse.copy(response, updateExpiry: false);

    await getIt<SharedPrefsManager>().saveUser(homeBloc.loginResponse);

    homeBloc.add(ProfileImageChangedEvent());
    MySnackbar.showSnackbar(response.message);

    emit(UpdateProfileSuccessNavigateState());
  }

  // homeBloc.add(ProfileImageChangedEvent());
}

Future<String?> __uploadProfileImage(
  UpdateProfileEvent event,
  Emitter<ProfileState> emit,
) async {
  Map<String, dynamic> response = {};

  File file = File(profileBloc.image!.path);

  response = await NetworkApiService().multipartApiCall(file);
  if (response.containsKey("image_url")) {
    // homeBloc.imageUrl = response['image_url'];
    return response['image_url'];
  } else {
    ErrorMessages.display(response['message']);
    emit(UpdateProfileErrorState());
    return null;
  }
}
