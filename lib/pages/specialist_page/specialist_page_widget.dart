import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../material_kit/custom_functions.dart' as functions;
import '../../material_kit/material_kit_icon_button.dart';
import '../../material_kit/material_kit_theme.dart';
import '../../material_kit/material_kit_util.dart';
import 'specialist_page_model.dart';

export 'specialist_page_model.dart';

class SpecialistPageWidget extends StatefulWidget {
  const SpecialistPageWidget({
    Key? key,
    required this.doctors,
    required this.specialist,
  }) : super(key: key);

  final dynamic doctors;
  final String? specialist;

  @override
  _SpecialistPageWidgetState createState() => _SpecialistPageWidgetState();
}

class _SpecialistPageWidgetState extends State<SpecialistPageWidget> {
  late SpecialistPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SpecialistPageModel());
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MaterialKitIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 10.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          fillColor:
                              MaterialKitTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: MaterialKitTheme.of(context).secondaryText,
                            size: 20.0,
                          ),
                          onPressed: () async {
                            context.pop();
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Spesialis ${widget.specialist}',
                                  style:
                                      MaterialKitTheme.of(context).titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Dokter Terdekat',
                          style: MaterialKitTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: MaterialKitTheme.of(context).primaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final doctorData = getJsonField(
                          widget.doctors,
                          r'''$[*]''',
                        ).toList();
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: doctorData.length,
                          itemBuilder: (context, doctorDataIndex) {
                            final doctorDataItem = doctorData[doctorDataIndex];
                            return Visibility(
                              visible: functions.isSearchMatched(
                                  widget.specialist!,
                                  (String specialist) {
                                    return [specialist];
                                  }(getJsonField(
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
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: MaterialKitTheme.of(context)
                                        .secondaryBackground,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            getJsonField(
                                              doctorDataItem,
                                              r'''$.img_url''',
                                            ),
                                            width: 100.0,
                                            height: 100.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 5.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 5.0, 0.0, 0.0),
                                                  child: Text(
                                                    getJsonField(
                                                      doctorDataItem,
                                                      r'''$.name''',
                                                    ).toString(),
                                                    textAlign: TextAlign.center,
                                                    style: MaterialKitTheme.of(
                                                            context)
                                                        .titleMedium,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 3.0, 0.0, 0.0),
                                                  child: Text(
                                                    '${getJsonField(
                                                      doctorDataItem,
                                                      r'''$.specialist''',
                                                    ).toString()} • ${getJsonField(
                                                      doctorDataItem,
                                                      r'''$.city''',
                                                    ).toString()}',
                                                    style: MaterialKitTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: MaterialKitTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 10.0, 0.0, 0.0),
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
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star_rounded,
                                                            color: MaterialKitTheme
                                                                    .of(context)
                                                                .secondary,
                                                          ),
                                                          direction:
                                                              Axis.horizontal,
                                                          rating: getJsonField(
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
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color: MaterialKitTheme
                                                                      .of(context)
                                                                  .primary,
                                                              size: 20.0,
                                                            ),
                                                            Text(
                                                              '${getJsonField(
                                                                doctorDataItem,
                                                                r'''$.distance''',
                                                              ).toString()} KM',
                                                              style: MaterialKitTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: MaterialKitTheme.of(
                                                                            context)
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
  }
}
