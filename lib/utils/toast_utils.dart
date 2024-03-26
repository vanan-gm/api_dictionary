import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  ToastUtils._();

  static void showSuccessToast() {
    Fluttertoast.showToast(
        msg: 'Copied to clipboard',
        fontSize: AppConstants.fontDefaultSize,
        backgroundColor: AppColors.blue,
        textColor: AppColors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }
}
