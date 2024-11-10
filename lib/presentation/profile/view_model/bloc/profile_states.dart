import 'package:roboti_app/base_redux/base_state.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileImageUpdatedState extends ProfileState with LoaderState {}

class UpdateProfileErrorState extends ProfileState {}

class UpdateProfileLoadingState extends ProfileState with LoaderState {}

class UpdateProfileSuccessState extends ProfileState {}

class UpdateProfileSuccessNavigateState extends ProfileState {}