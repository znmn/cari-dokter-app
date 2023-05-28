import 'package:flutter/material.dart';

import '../../material_kit/material_kit_util.dart';

class LoginPageModel extends MaterialKitModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for loginEmail widget.
  TextEditingController? loginEmailController;
  String? Function(BuildContext, String?)? loginEmailControllerValidator;
  // State field(s) for loginPassword widget.
  TextEditingController? loginPasswordController;
  late bool loginPasswordVisibility;
  String? Function(BuildContext, String?)? loginPasswordControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    loginPasswordVisibility = false;
  }

  void dispose() {
    loginEmailController?.dispose();
    loginPasswordController?.dispose();
  }

  /// Additional helper methods are added here.
}
