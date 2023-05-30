import 'package:flutter/material.dart';

import '/backend/api_requests/api_calls.dart';
import '../../material_kit/material_kit_util.dart';

class VerificationPageModel extends MaterialKitModel {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (imgRecognition)] action in Button widget.
  ApiCallResponse? reconitionRes;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.
}
