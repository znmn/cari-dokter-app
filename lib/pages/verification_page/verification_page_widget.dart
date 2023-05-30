import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '../../material_kit/material_kit_theme.dart';
import '../../material_kit/material_kit_util.dart';
import '../../material_kit/material_kit_widgets.dart';
import '../../material_kit/upload_data.dart';
import 'verification_page_model.dart';

export 'verification_page_model.dart';

class VerificationPageWidget extends StatefulWidget {
  const VerificationPageWidget({Key? key}) : super(key: key);

  @override
  _VerificationPageWidgetState createState() => _VerificationPageWidgetState();
}

class _VerificationPageWidgetState extends State<VerificationPageWidget> {
  late VerificationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerificationPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: MaterialKitTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: MaterialKitTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Verifikasi Bukan Robot',
            style: MaterialKitTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * 1.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MaterialKitTheme.of(context).primaryBackground,
                  MaterialKitTheme.of(context).secondaryBackground,
                  MaterialKitTheme.of(context).primaryBackground
                ],
                stops: [0.0, 0.5, 1.0],
                begin: AlignmentDirectional(0.64, 1.0),
                end: AlignmentDirectional(-0.64, -1.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Ambil Selfie',
                        style: MaterialKitTheme.of(context).titleLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          'Kami akan memverifikasinya dengan program face recognition',
                          style: MaterialKitTheme.of(context).bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                        child: Icon(
                          Icons.face,
                          color: MaterialKitTheme.of(context).secondary,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Menghadap ke depan dan pastikan mata Anda terlihat jelas',
                            style: MaterialKitTheme.of(context).bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.glasses,
                          color: MaterialKitTheme.of(context).secondary,
                          size: 22.0,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Lepaskan kacamata Anda jika perlu',
                            style: MaterialKitTheme.of(context).bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 215.0, 0.0, 20.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      var _shouldSetState = false;
                      final selectedMedia = await selectMedia(
                        maxWidth: 512.00,
                        maxHeight: 512.00,
                        imageQuality: 100,
                        multiImage: false,
                      );
                      if (selectedMedia != null &&
                          selectedMedia.every((m) =>
                              validateFileFormat(m.storagePath, context))) {
                        setState(() => _model.isDataUploading = true);
                        var selectedUploadedFiles = <FFUploadedFile>[];
                        var downloadUrls = <String>[];
                        try {
                          selectedUploadedFiles = selectedMedia
                              .map((m) => FFUploadedFile(
                                    name: m.storagePath.split('/').last,
                                    bytes: m.bytes,
                                    height: m.dimensions?.height,
                                    width: m.dimensions?.width,
                                    blurHash: m.blurHash,
                                  ))
                              .toList();

                          downloadUrls = (await Future.wait(
                            selectedMedia.map(
                              (m) async =>
                                  await uploadData(m.storagePath, m.bytes),
                            ),
                          ))
                              .where((u) => u != null)
                              .map((u) => u!)
                              .toList();
                        } finally {
                          _model.isDataUploading = false;
                        }
                        if (selectedUploadedFiles.length ==
                                selectedMedia.length &&
                            downloadUrls.length == selectedMedia.length) {
                          setState(() {
                            _model.uploadedLocalFile =
                                selectedUploadedFiles.first;
                            _model.uploadedFileUrl = downloadUrls.first;
                          });
                        } else {
                          setState(() {});
                          return;
                        }
                      }

                      _model.reconitionRes =
                          await PbmApiGroup.imgRecognitionCall.call(
                        photoUrl: _model.uploadedFileUrl,
                      );
                      _shouldSetState = true;
                      if (getJsonField(
                        (_model.reconitionRes?.jsonBody ?? ''),
                        r'''$.detected''',
                      )) {
                        final usersUpdateData = createUsersRecordData(
                          photoUrl: _model.uploadedFileUrl,
                          isVerified: true,
                        );
                        await currentUserReference!.update(usersUpdateData);
                        setState(() {
                          _model.isDataUploading = false;
                          _model.uploadedLocalFile =
                              FFUploadedFile(bytes: Uint8List.fromList([]));
                          _model.uploadedFileUrl = '';
                        });

                        context.pushNamed('HomePage');

                        if (_shouldSetState) setState(() {});
                        return;
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Gagal'),
                              content:
                                  Text('Wajah tidak terdeteksi dalam foto'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {
                          _model.isDataUploading = false;
                          _model.uploadedLocalFile =
                              FFUploadedFile(bytes: Uint8List.fromList([]));
                          _model.uploadedFileUrl = '';
                        });

                        if (_shouldSetState) setState(() {});
                        return;
                      }
                    },
                    text: 'Ambil Selfie',
                    options: FFButtonOptions(
                      width: 328.0,
                      height: 48.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: MaterialKitTheme.of(context).primary,
                      textStyle:
                          MaterialKitTheme.of(context).titleSmall.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
