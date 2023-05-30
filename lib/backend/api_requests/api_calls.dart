import '../../material_kit/material_kit_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

/// Start pbmApi Group Code

class PbmApiGroup {
  static String baseUrl = 'http://c9.devclass.me:5000';
  static Map<String, String> headers = {
    'Secret': 'PBMOnly',
  };
  static GetDoctorsCall getDoctorsCall = GetDoctorsCall();
  static GetNewsCall getNewsCall = GetNewsCall();
  static ImgRecognitionCall imgRecognitionCall = ImgRecognitionCall();
}

class GetDoctorsCall {
  Future<ApiCallResponse> call({
    String? latitude = '-8.164911',
    String? longitude = '113.703714',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getDoctors',
      apiUrl: '${PbmApiGroup.baseUrl}/doctors',
      callType: ApiCallType.GET,
      headers: {
        ...PbmApiGroup.headers,
      },
      params: {
        'lat': latitude,
        'long': longitude,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class GetNewsCall {
  Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getNews',
      apiUrl: '${PbmApiGroup.baseUrl}/news',
      callType: ApiCallType.GET,
      headers: {
        ...PbmApiGroup.headers,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic articles(dynamic response) => getJsonField(
        response,
        r'''$.articles''',
        true,
      );
}

class ImgRecognitionCall {
  Future<ApiCallResponse> call({
    String? photoUrl = '',
  }) {
    final body = '''
{
  "img_url": "$photoUrl"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'imgRecognition',
      apiUrl: '${PbmApiGroup.baseUrl}/recognition',
      callType: ApiCallType.POST,
      headers: {
        ...PbmApiGroup.headers,
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  dynamic detected(dynamic response) => getJsonField(
        response,
        r'''$.detected''',
      );
}

/// End pbmApi Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}
