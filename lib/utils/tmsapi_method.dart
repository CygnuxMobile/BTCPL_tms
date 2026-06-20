import 'package:btcpl/utils/pref.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../app_routes.dart';
import '../widgets/tms_alert_dialog.dart';

class WebService {
  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );
  static final Dio _dio = Dio()
    ..interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));

  static void initializeDio() {
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, handler) async {
        if (isUnAuthorized(response)) {
          await TmsAlertDialog(
            Get.context!,
            Sajesan: 'this user is login other device',
            onpressed: () {
              Pref().clearPreferencesData();
              Get.offAllNamed(AppRoutes.loginScreen);
            },
            text: 'Continue',
            cancel: false,
          );
        }
        return handler.next(response);
      },
    ));
  }

  /// get api
  static Future<Response> tmsGetRequest(String url) async {
    Response response = await _dio.get(
      url,
      options: Options(
          method: 'GET',
          headers: {
            'Authorization': "Bearer ${Pref().getToken()}",
          },
          responseType: ResponseType.plain),
    );
    return response;
  }

  /// post api
  static Future<Response> tmsPostRequest({required String url, required String body}) async {
    Response response = await _dio.post(
      url,
      data: body,
      options: Options(
          method: 'POST',
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.plain),
    );

    return response;
  }

  /// post token api
  static Future<Response> tmsPostTokenRequest({required String url, required String body}) async {
    Response response = await _dio.post(
      url,
      data: body,
      options: Options(
          method: 'POST',
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': "Bearer ${Pref().getToken()}",
          },
          responseType: ResponseType.plain),
    );
    return response;
  }

  /// multi part
  static Future<String> tmsMultiPartRequest(
      {required String url, required String pOdImage, required String podImageBack}) async {
    // var formData = FormData();
    // formData.files.add(
    //   MapEntry('PODImage', await MultipartFile.fromFile(File(pOdImage).path)),
    // );
    // formData.files.add(
    //   MapEntry('PODImageBack', await MultipartFile.fromFile(File(podImageBack).path)),
    // );

    var headers = {'accept': '*/*'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('PODImage', pOdImage));
    request.files.add(await http.MultipartFile.fromPath('PODImageBack', podImageBack));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    // var formData = FormData.fromMap(
    //   {
    //     // need to await for this async operation
    //     "PODImage":  MultipartFile.fromFileSync(File(pOdImage).path,
    //         filename: File(pOdImage).path.split('/').last),
    //     "PODImageBack":  MultipartFile.fromFileSync(File(podImageBack).path,
    //         filename: File(podImageBack).path.split('/').last),
    //   },
    // );
    //
    // Response response = await _dio.
    // post(
    //   url,
    //   data: formData,
    //   options: Options(method: 'POST', headers: {
    //     'accept': '*/*',
    //   }, responseType: ResponseType.plain),
    // );
    return await response.stream.bytesToString();
  }

  static Future<http.StreamedResponse> multiPartRequest({
    required String url,
    required String podImage,
    required String podImageBack,
  }) async {
    logger.i("URL: $url");

    var headers = {
      'accept': '*/*',
      'Authorization': "Bearer ${Pref().getToken()}",
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    if (podImage.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('PODImage', podImage));
    }
    if (podImageBack.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('PODImageBack', podImageBack));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      logger.i("Upload success");
      return response;
    } else {
      logger.e("Upload failed: ${response.statusCode}");
      return response;
    }
  }
}

bool isUnAuthorized(Response response) {
  final int statusCode = response.statusCode!;
  if (statusCode == 401) return true;
  return false;
}
