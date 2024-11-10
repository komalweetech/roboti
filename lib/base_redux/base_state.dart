import 'package:roboti_app/utils/enums/api_name.dart';
import 'package:roboti_app/utils/enums/status_enum.dart';

class AppState {
  final dynamic payloadData;
  final ApiName? type;
  final ResponseStatus? status;
  final String? error;

  const AppState({
    this.payloadData,
    this.type,
    this.status,
    this.error,
  });
}

mixin LoaderState {}

class AppStateGet extends AppState {
  const AppStateGet({
    dynamic payloadData,
    ApiName? type,
    ResponseStatus? status,
    String? error,
  }) : super(
          payloadData: payloadData,
          type: type,
          status: status,
          error: error,
        );
}

class AppStateAdd extends AppState {
  const AppStateAdd({
    dynamic payloadData,
    ApiName? type,
    ResponseStatus? status,
    String? error,
  }) : super(
          payloadData: payloadData,
          type: type,
          status: status,
          error: error,
        );
}

class AppStateUpdate extends AppState {
  const AppStateUpdate({
    dynamic payloadData,
    ApiName? type,
    ResponseStatus? status,
    String? error,
  }) : super(
          payloadData: payloadData,
          type: type,
          status: status,
          error: error,
        );
}

class AppStateDelete extends AppState {
  const AppStateDelete({
    dynamic payloadData,
    ApiName? type,
    ResponseStatus? status,
    String? error,
  }) : super(
          payloadData: payloadData,
          type: type,
          status: status,
          error: error,
        );
}
