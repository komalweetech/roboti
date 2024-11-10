import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_event_handler.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_events.dart';
import 'package:roboti_app/presentation/profile/view_model/bloc/profile_states.dart';

final ProfileBloc profileBloc = ProfileBloc();

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  XFile? image;
  ProfileBloc({this.image}) : super(ProfileInitialState()) {
    on<ProfileEvent>(ProfileEventsHandler().profileHandler);
  }
}
