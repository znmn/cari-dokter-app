import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '../../material_kit/custom_functions.dart' as functions;
import '../../material_kit/material_kit_icon_button.dart';
import '../../material_kit/material_kit_theme.dart';
import '../../material_kit/material_kit_util.dart';
import '../../material_kit/material_kit_widgets.dart';
import 'order_doctor_page_model.dart';

export 'order_doctor_page_model.dart';

class OrderDoctorPageWidget extends StatefulWidget {
  const OrderDoctorPageWidget({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final dynamic doctor;

  @override
  _OrderDoctorPageWidgetState createState() => _OrderDoctorPageWidgetState();
}

class _OrderDoctorPageWidgetState extends State<OrderDoctorPageWidget> {
  late OrderDoctorPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderDoctorPageModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
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
      future: PbmApiGroup.estimateFareCall.call(
        lat1: getJsonField(
          widget.doctor,
          r'''$.location.latitude''',
        ),
        long1: getJsonField(
          widget.doctor,
          r'''$.location.longitude''',
        ),
        lat2: functions.getLatLng(currentUserLocationValue!).first,
        long2: functions.getLatLng(currentUserLocationValue!).last,
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
        final orderDoctorPageEstimateFareResponse = snapshot.data!;
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
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialKitIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 10.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              fillColor: MaterialKitTheme.of(context)
                                  .secondaryBackground,
                              icon: Icon(
                                Icons.arrow_back_ios_outlined,
                                color:
                                    MaterialKitTheme.of(context).secondaryText,
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
                                      'Pesan Dokter',
                                      style: MaterialKitTheme.of(context)
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              MaterialKitTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        getJsonField(
                                          widget.doctor,
                                          r'''$.img_url''',
                                        ),
                                        width: 85.0,
                                        height: 85.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getJsonField(
                                          widget.doctor,
                                          r'''$.name''',
                                        ).toString(),
                                        style: MaterialKitTheme.of(context)
                                            .titleMedium,
                                      ),
                                      Text(
                                        getJsonField(
                                          widget.doctor,
                                          r'''$.specialist''',
                                        ).toString(),
                                        style: MaterialKitTheme.of(context)
                                            .bodySmall
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  MaterialKitTheme.of(context)
                                                      .secondaryText,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 35.0, 0.0),
                                            child: RatingBarIndicator(
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star_rounded,
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondary,
                                              ),
                                              direction: Axis.horizontal,
                                              rating: getJsonField(
                                                widget.doctor,
                                                r'''$.rating''',
                                              ).toDouble(),
                                              unratedColor:
                                                  MaterialKitTheme.of(context)
                                                      .accent2,
                                              itemCount: 5,
                                              itemSize: 15.0,
                                            ),
                                          ),
                                          Icon(
                                            Icons.location_pin,
                                            color: Color(0xFF4285F4),
                                            size: 19.0,
                                          ),
                                          Text(
                                            getJsonField(
                                              widget.doctor,
                                              r'''$.city''',
                                            ).toString(),
                                            style: MaterialKitTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: MaterialKitTheme.of(
                                                          context)
                                                      .secondaryText,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 24.0, 20.0, 0.0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color:
                              MaterialKitTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 10.0, 5.0, 10.0),
                                child: Container(
                                  width: 85.0,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: MaterialKitTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          'KM',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color: Color(0xFF4285F4),
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            widget.doctor,
                                            r'''$.distance''',
                                          ).toString(),
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 10.0, 5.0, 10.0),
                                child: Container(
                                  width: 85.0,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: MaterialKitTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidStar,
                                          color: MaterialKitTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            widget.doctor,
                                            r'''$.rating''',
                                          ).toString(),
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 10.0, 5.0, 10.0),
                                child: Container(
                                  width: 85.0,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    color: MaterialKitTheme.of(context)
                                        .primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          'Rp',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .success,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            widget.doctor,
                                            r'''$.price_rate''',
                                          ).toString(),
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryText,
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
                            20.0, 30.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Estimasi Harga',
                                  style:
                                      MaterialKitTheme.of(context).titleLarge,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 25.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Biaya Dokter',
                                        style: MaterialKitTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  MaterialKitTheme.of(context)
                                                      .secondaryText,
                                            ),
                                      ),
                                      Text(
                                        'Rp${getJsonField(
                                          widget.doctor,
                                          r'''$.price_rate''',
                                        ).toString()}',
                                        style: MaterialKitTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Poppins',
                                              color:
                                                  MaterialKitTheme.of(context)
                                                      .secondaryText,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Biaya Transportasi (PP)',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                        Text(
                                          r'''$.distance''' != null
                                              ? 'Rp${(10000 * double.parse(r'''$.distance''') * 2).toStringAsFixed(2)}'
                                              : '(Jarak Terlalu Jauh)',
                                          style: MaterialKitTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Biaya',
                                          style: MaterialKitTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    MaterialKitTheme.of(context)
                                                        .primaryText,
                                              ),
                                        ),
                                        Text(
                                          getJsonField(
                                                    orderDoctorPageEstimateFareResponse
                                                        .jsonBody,
                                                    r'''$.pp''',
                                                  ) !=
                                                  null
                                              ? 'Rp${(functions.sumList((int doctorRate, int ppRate) {
                                                    return [doctorRate, ppRate];
                                                  }(getJsonField(widget.doctor, r'''$.price_rate'''), getJsonField(orderDoctorPageEstimateFareResponse.jsonBody, r'''$.pp''')).toList()) + (r'''$.distance''' != null ? (10000 * double.parse(r'''$.distance''') * 2) : 0)).toString()}'
                                              : 'Gagal Hitung Estimasi',
                                          style: MaterialKitTheme.of(context)
                                              .bodyLarge,
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (getJsonField(
                                  orderDoctorPageEstimateFareResponse.jsonBody,
                                  r'''$.pp''',
                                ) ==
                                null) {
                              context.goNamed('HomePage');

                              return;
                            } else {
                              return;
                            }
                          },
                          text: 'Pesan',
                          options: FFButtonOptions(
                            width: 290.0,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: MaterialKitTheme.of(context).primary,
                            textStyle: MaterialKitTheme.of(context)
                                .titleMedium
                                .override(
                                  fontFamily: 'Poppins',
                                  color: MaterialKitTheme.of(context)
                                      .secondaryBackground,
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
          ),
        );
      },
    );
  }
}
