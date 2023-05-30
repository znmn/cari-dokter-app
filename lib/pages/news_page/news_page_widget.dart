import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '../../material_kit/custom_functions.dart' as functions;
import '../../material_kit/material_kit_icon_button.dart';
import '../../material_kit/material_kit_theme.dart';
import '../../material_kit/material_kit_util.dart';
import 'news_page_model.dart';

export 'news_page_model.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({Key? key}) : super(key: key);

  @override
  _NewsPageWidgetState createState() => _NewsPageWidgetState();
}

class _NewsPageWidgetState extends State<NewsPageWidget> {
  late NewsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewsPageModel());

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

    return FutureBuilder<ApiCallResponse>(
      future: PbmApiGroup.getNewsCall.call(),
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
        final newsPageGetNewsResponse = snapshot.data!;
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
                                          'Berita Kesehatan',
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
                                                  hintText: 'Cari Berita...',
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
                              'Daftar Berita',
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
                            final articles = getJsonField(
                              newsPageGetNewsResponse.jsonBody,
                              r'''$.articles''',
                            ).toList();
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: articles.length,
                              itemBuilder: (context, articlesIndex) {
                                final articlesItem = articles[articlesIndex];
                                return Visibility(
                                  visible: functions.isSearchMatched(
                                      _model.searchFieldController.text,
                                      (String title,
                                                  String description,
                                                  String content,
                                                  String source) {
                                        return [
                                          title,
                                          description,
                                          content,
                                          source
                                        ];
                                      }(
                                              getJsonField(
                                                articlesItem,
                                                r'''$.title''',
                                              ).toString(),
                                              getJsonField(
                                                articlesItem,
                                                r'''$.description''',
                                              ).toString(),
                                              getJsonField(
                                                articlesItem,
                                                r'''$.content''',
                                              ).toString(),
                                              getJsonField(
                                                articlesItem,
                                                r'''$.source.name''',
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
                                          'NewsDetailPage',
                                          queryParams: {
                                            'news': serializeParam(
                                              articlesItem,
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
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 10.0, 0.0, 0.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    getJsonField(
                                                      articlesItem,
                                                      r'''$.urlToImage''',
                                                    ),
                                                    'https://cdn.discordapp.com/attachments/1106947402088325200/1106947457574768670/favicon.png',
                                                  ),
                                                  width: 100.0,
                                                  height: 100.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 5.0, 0.0),
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
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: AutoSizeText(
                                                        valueOrDefault<String>(
                                                          (String title) {
                                                            return (title.length >=
                                                                        36
                                                                    ? title
                                                                        .substring(
                                                                            0,
                                                                            36)
                                                                    : title) +
                                                                "...";
                                                          }(getJsonField(
                                                            articlesItem,
                                                            r'''$.title''',
                                                          ).toString()),
                                                          'Judul Berita',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: MaterialKitTheme
                                                                .of(context)
                                                            .titleMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  3.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: AutoSizeText(
                                                        valueOrDefault<String>(
                                                          (String description) {
                                                            return (description
                                                                            .length >=
                                                                        36
                                                                    ? description
                                                                        .substring(
                                                                            0,
                                                                            36)
                                                                    : description) +
                                                                "...";
                                                          }(getJsonField(
                                                            articlesItem,
                                                            r'''$.description''',
                                                          ).toString()),
                                                          'Deskripsi Berita',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
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
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            color: MaterialKitTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 22.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: AutoSizeText(
                                                              valueOrDefault<
                                                                  String>(
                                                                getJsonField(
                                                                  articlesItem,
                                                                  r'''$.source.name''',
                                                                ).toString(),
                                                                'Sumber',
                                                              ),
                                                              style: MaterialKitTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .date_range_rounded,
                                                            color: MaterialKitTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 22.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: AutoSizeText(
                                                              valueOrDefault<
                                                                  String>(
                                                                (String
                                                                    timestamp) {
                                                                  return timestamp
                                                                      .split(
                                                                          'T')[0];
                                                                }(getJsonField(
                                                                  articlesItem,
                                                                  r'''$.publishedAt''',
                                                                ).toString()),
                                                                'Waktu Publish',
                                                              ),
                                                              style: MaterialKitTheme
                                                                      .of(context)
                                                                  .bodyMedium,
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
