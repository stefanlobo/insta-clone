import 'package:flutter/material.dart';
import 'package:insta_clone/views/components/constants/strings.dart';
import 'package:insta_clone/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
    : super(
        title: Strings.logOut,
        message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
        buttons: const {Strings.cancel: false, Strings.logOut: true},
      );
}
