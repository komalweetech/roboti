import 'package:roboti_app/base_redux/base_state.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

// GLOBAL NEWS STATE
abstract class GlobalNewsState extends NewsState {}

class GlobalNewsDataLoadedSuccessState extends GlobalNewsState {}

class GlobalNewsDataLoadedLoadingState extends GlobalNewsState
    with LoaderState {}

class GlobalNewsDataLoadedErrorState extends GlobalNewsState {}

class GetAllGNewsPaginationLoadingState extends GlobalNewsState {}

// ROBOTI NEWS STATE
abstract class RobotiNewsState extends NewsState {}

class RobotiNewsDataLoadedSuccessState extends RobotiNewsState {}

class RobotiNewsDataLoadedLoadingState extends RobotiNewsState
    with LoaderState {}

class RobotiNewsDataLoadedErrorState extends RobotiNewsState {}
