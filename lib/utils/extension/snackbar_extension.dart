import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:timerflow/services/snackbar_service.dart';

extension SnackbarX on BuildContext {
  void showSuccess(String message, {String title = "Success"}) {
    SnackbarService.showSnack(
      this,
      title: title,
      message: message,
      type: ContentType.success,
    );
  }

  void showError(String message, {String title = "Error"}) {
    SnackbarService.showSnack(
      
      this,
      title: title,
      message: message,
      type: ContentType.failure,
    );
  }

  void showWarning(String message, {String title = "Warning"}) {
    SnackbarService.showSnack(
      this,
      title: title,
      message: message,
      type: ContentType.warning,
    );
  }
}
