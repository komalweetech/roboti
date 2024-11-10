import 'package:roboti_app/utils/enums/api_name.dart';
import 'package:roboti_app/utils/enums/status_enum.dart';

// Any state that is used for api integration will basically have following
// information so they eventually subscribe to the contract below so that
// any state not containing one of the following information will throww error
abstract class ApiState {
  late ResponseStatus responseStatus;
  late ApiName apiName;
  late String? errorMessage;
}
