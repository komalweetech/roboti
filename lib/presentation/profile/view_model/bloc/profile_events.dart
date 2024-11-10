import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {}

class GotoEditProfileEvent extends ProfileEvent {
  final BuildContext context;
  GotoEditProfileEvent({required this.context});
}

class UpdateProfileEvent extends ProfileEvent {
  final String name, country;
  final XFile? file;

  UpdateProfileEvent({
    required this.name,
    required this.country,
    required this.file,
  });
}

// class GetUserProfileEvent extends ProfileEvent {}
