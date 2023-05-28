import 'package:flutter/material.dart';

import '../../material_kit/material_kit_util.dart';

class RegisterPageModel extends MaterialKitModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for registerEmail widget.
  TextEditingController? registerEmailController;
  String? Function(BuildContext, String?)? registerEmailControllerValidator;
  // State field(s) for registerPassword widget.
  TextEditingController? registerPasswordController;
  late bool registerPasswordVisibility;
  String? Function(BuildContext, String?)? registerPasswordControllerValidator;
  // State field(s) for confirmPassword widget.
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    registerPasswordVisibility = false;
    confirmPasswordVisibility = false;
  }

  void dispose() {
    registerEmailController?.dispose();
    registerPasswordController?.dispose();
    confirmPasswordController?.dispose();
  }

  /// Additional helper methods are added here.
}
