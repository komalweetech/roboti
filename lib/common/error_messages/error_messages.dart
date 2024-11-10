import 'package:roboti_app/common/widget/snack_bar/my_snackbar.dart';
import 'package:roboti_app/theme/my_colors.dart';

class ErrorMessages {
  static Future<void> display(
    String message, {
    int durationInMS = 1500,
  }) async {
    await MySnackbar.showSnackbar(
      message,
      bgColor: MyColors.red,
      msgColor: MyColors.whiteFFFFFF,
      durationMS: durationInMS,
    );
  }
}
