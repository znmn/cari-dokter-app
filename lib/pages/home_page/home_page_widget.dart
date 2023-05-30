import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '../../material_kit/custom_functions.dart' as functions;
import '../../material_kit/material_kit_icon_button.dart';
import '../../material_kit/material_kit_theme.dart';
import '../../material_kit/material_kit_util.dart';
import 'home_page_model.dart';

export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    _model.searchFieldController ??= TextEditingController();
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
    if (currentUserLocationValue == null) {
      return Container(
        color: MaterialKitTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitCubeGrid(
              color: MaterialKitTheme.of(context).primary,
              size: 50.0,
            ),
          ),
        ),
      );
    }

    return FutureBuilder<ApiCallResponse>(
      future: PbmApiGroup.getDoctorsCall.call(
        latitude:
            (functions.getLatLng(currentUserLocationValue!).first).toString(),
        longitude:
            (functions.getLatLng(currentUserLocationValue!).last).toString(),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitCubeGrid(
                color: MaterialKitTheme.of(context).primary,
                size: 50.0,
              ),
            ),
          );
        }
        final homePageGetDoctorsResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: MaterialKitTheme.of(context).primaryBackground,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              height: 155.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    MaterialKitTheme.of(context).primary,
                                    Color(0xFF36C08E)
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: AlignmentDirectional(1.0, 0.0),
                                  end: AlignmentDirectional(-1.0, 0),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(0.0),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: SingleChildScrollView(
                              primary: false,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cari Dokter Mu',
                                          style: MaterialKitTheme.of(context)
                                              .titleLarge
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                        ),
                                        Container(
                                          width: 35.0,
                                          height: 35.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset(
                                            'assets/images/favicon.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20.0, 20.0, 20.0, 0.0),
                                    child: Container(
                                      width: 330.0,
                                      height: 55.0,
                                      decoration: BoxDecoration(
                                        color: MaterialKitTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: MaterialKitTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                            child: Icon(
                                              Icons.search,
                                              color:
                                                  MaterialKitTheme.of(context)
                                                      .secondaryText,
                                              size: 15.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: TextFormField(
                                                controller: _model
                                                    .searchFieldController,
                                                onChanged: (_) =>
                                                    EasyDebounce.debounce(
                                                  '_model.searchFieldController',
                                                  Duration(milliseconds: 500),
                                                  () => setState(() {}),
                                                ),
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Cari Dokter...',
                                                  hintStyle: MaterialKitTheme
                                                          .of(context)
                                                      .titleMedium
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            MaterialKitTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                      ),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  focusedErrorBorder:
                                                      InputBorder.none,
                                                ),
                                                style:
                                                    MaterialKitTheme.of(context)
                                                        .bodyMedium,
                                                validator: _model
                                                    .searchFieldControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                          MaterialKitIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 10.0,
                                            borderWidth: 0.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.close,
                                              color:
                                                  MaterialKitTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                _model.searchFieldController
                                                    ?.clear();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Cari Spesialis',
                              style: MaterialKitTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: MaterialKitTheme.of(context)
                                        .primaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 90.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'Umum',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.stethoscope,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'Umum',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'Gigi',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.tooth,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'Gigi',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'THT',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.hearing,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'THT',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'KIA',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.baby,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'KIA',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'Saraf',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.brain,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'Saraf',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'Paru',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.lungs,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'Paru',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 10.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'SpecialistPage',
                                      queryParams: {
                                        'doctors': serializeParam(
                                          getJsonField(
                                            homePageGetDoctorsResponse.jsonBody,
                                            r'''$''',
                                          ),
                                          ParamType.JSON,
                                        ),
                                        'specialist': serializeParam(
                                          'Mata',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                          color: MaterialKitTheme.of(context)
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.eye,
                                          color: MaterialKitTheme.of(context)
                                              .secondaryBackground,
                                          size: 25.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 2.0, 0.0, 0.0),
                                        child: Text(
                                          'Mata',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primary,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Dokter Terdekat',
                              style: MaterialKitTheme.of(context)
                                  .titleMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: MaterialKitTheme.of(context)
                                        .primaryText,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 20.0),
                        child: Builder(
                          builder: (context) {
                            final doctorData = getJsonField(
                              homePageGetDoctorsResponse.jsonBody,
                              r'''$''',
                            ).toList();
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: doctorData.length,
                              itemBuilder: (context, doctorDataIndex) {
                                final doctorDataItem =
                                    doctorData[doctorDataIndex];
                                return Visibility(
                                  visible: functions.isSearchMatched(
                                      _model.searchFieldController.text,
                                      (String name, String specialist) {
                                        return [name, specialist];
                                      }(
                                              getJsonField(
                                                doctorDataItem,
                                                r'''$.name''',
                                              ).toString(),
                                              getJsonField(
                                                doctorDataItem,
                                                r'''$.specialist''',
                                              ).toString())
                                          .toList()),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'DoctorPage',
                                          queryParams: {
                                            'doctor': serializeParam(
                                              doctorDataItem,
                                              ParamType.JSON,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: MaterialKitTheme.of(context)
                                            .secondaryBackground,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  getJsonField(
                                                    doctorDataItem,
                                                    r'''$.img_url''',
                                                  ),
                                                  'https://cdn.discordapp.com/attachments/1106947402088325200/1106947457574768670/favicon.png',
                                                ),
                                                width: 100.0,
                                                height: 100.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 5.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        getJsonField(
                                                          doctorDataItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            MaterialKitTheme.of(
                                                                    context)
                                                                .titleMedium,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  3.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        '${getJsonField(
                                                          doctorDataItem,
                                                          r'''$.specialist''',
                                                        ).toString()} • ${getJsonField(
                                                          doctorDataItem,
                                                          r'''$.city''',
                                                        ).toString()}',
                                                        style:
                                                            MaterialKitTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: MaterialKitTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                            child:
                                                                RatingBarIndicator(
                                                              itemBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Icon(
                                                                Icons
                                                                    .star_rounded,
                                                                color: MaterialKitTheme.of(
                                                                        context)
                                                                    .secondary,
                                                              ),
                                                              direction: Axis
                                                                  .horizontal,
                                                              rating:
                                                                  getJsonField(
                                                                doctorDataItem,
                                                                r'''$.rating''',
                                                              ).toDouble(),
                                                              unratedColor:
                                                                  MaterialKitTheme.of(
                                                                          context)
                                                                      .accent2,
                                                              itemCount: 5,
                                                              itemSize: 20.0,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        6.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: MaterialKitTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 20.0,
                                                                ),
                                                                Text(
                                                                  '${getJsonField(
                                                                    doctorDataItem,
                                                                    r'''$.distance''',
                                                                  ).toString()} KM',
                                                                  style: MaterialKitTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        color: MaterialKitTheme.of(context)
                                                                            .secondaryText,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
