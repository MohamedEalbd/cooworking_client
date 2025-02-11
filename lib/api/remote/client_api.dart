import 'dart:convert';
import 'package:khidmh/common/models/errrors_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioPackage;
import 'package:khidmh/utils/core_export.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as foundation;


class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 200;

  String? token;
  String? languageCode;
  String? guestID;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    languageCode = sharedPreferences.getString(AppConstants.languageCode);
    guestID = sharedPreferences.getString(AppConstants.guestId);
    printLog('Token: $token');
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
      printLog( addressModel.toJson());
    }catch(e) {
      if (kDebugMode) {
        print('');
      }
    }

    ///pick zone id to update header
    updateHeader(
        token, addressModel?.zoneId,
        sharedPreferences.getString(AppConstants.languageCode), sharedPreferences.getString(AppConstants.guestId)
    );
  }
  void updateHeader(String? token, String? zoneIDs, String? languageCode, String? guestID) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: zoneIDs ?? '',
      AppConstants.localizationKey: languageCode ?? AppConstants.languages[0].languageCode!,
      if(token !=null)  'Authorization': 'Bearer $token',
      AppConstants.guestId : guestID ?? "",
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');

    dioPackage.Dio dio = dioPackage.Dio();
    dio.options.headers.addAll(headers ?? _mainHeaders);
    dio.options.connectTimeout = const Duration(milliseconds: 1000000);
    dio.options.receiveTimeout = const Duration(milliseconds: 1000000);

    DateTime startTime = DateTime.now();
    dioPackage.Response response;

    try {
      response = await dio.get(
        appBaseUrl! + uri,
        queryParameters: query,
      );
    } on dioPackage.DioException catch (e) {
      if (e.type == dioPackage.DioExceptionType.connectionTimeout ||
          e.type == dioPackage.DioExceptionType.receiveTimeout) {
        print("Request timeout");
        return Response(statusCode: 1, statusText: noInternetMessage);
      } else {
        print("Error: $e");
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }

    DateTime endTime = DateTime.now();
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.data}");
    print("Request duration: ${endTime.difference(startTime).inSeconds} seconds");

    return handleResponseDio(response, uri);
  }


  // Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers}) async {
  //   printLog('====> API Call: $uri\nHeader: $_mainHeaders');
  //   printLog('====> body : ${body.toString()}');
  //   printLog('====> body jsonEncode  : ${jsonEncode(body)}');
  //
  //
  //
  //   http.Response response = await http.post(
  //     Uri.parse(appBaseUrl! + uri!),
  //     body: jsonEncode(body),
  //     headers: headers ?? _mainHeaders,
  //   ).timeout(Duration(seconds: timeoutInSeconds));
  //
  //   print(response.body);
  //   try {
  //     return handleResponse(response, uri);
  //   } catch (e) {
  //
  //     return Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  // }
  // Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers,bool isCheckout=false}) async {
  //   printLog('====> API Call: $uri\nHeader: $_mainHeaders');
  //   printLog('====> body : ${body.toString()}');
  //   printLog('====> body jsonEncode  : ${jsonEncode(body)}');
  //
  //   Map<String, String>? header= {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //
  //     AppConstants.localizationKey: languageCode ?? AppConstants.languages[0].languageCode!,
  //     if(token !=null)  'Authorization': 'Bearer $token',
  //     AppConstants.guestId : guestID ?? "",
  //   };
  //   DateTime startTime = DateTime.now();
  //   http.Response response;
  //
  //   try {
  //     if(isCheckout) {
  //       response = await http.post(
  //         Uri.parse(appBaseUrl! + uri!),
  //         body: jsonEncode(body),
  //         headers: header ?? _mainHeaders,
  //       ).timeout(Duration(seconds: timeoutInSeconds));
  //     }else{
  //       response = await http.post(
  //         Uri.parse(appBaseUrl! + uri!),
  //         body: jsonEncode(body),
  //         headers: header ?? _mainHeaders,
  //       ).timeout(Duration(seconds: timeoutInSeconds));
  //     }
  //   } on TimeoutException catch (_) {
  //     print("Request timeout");
  //     return Response(statusCode: 1, statusText: noInternetMessage);
  //   } catch (e) {
  //     print("Error: $e");
  //     return Response(statusCode: 1, statusText: noInternetMessage);
  //   }
  //
  //   DateTime endTime = DateTime.now();
  //   print("Response status: ${response.statusCode}");
  //   print("Response body: ${response.body}");
  //   print("Request duration: ${endTime.difference(startTime).inSeconds} seconds");
  //
  //   return handleResponse(response, uri);
  // }



  Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    printLog('====> body : ${body.toString()}');
    printLog('====> body jsonEncode  : ${jsonEncode(body)}');

    dioPackage.Dio dio =  dioPackage.Dio();
    dio.options.headers.addAll(headers ?? _mainHeaders);
    dio.options.connectTimeout =  const Duration(milliseconds: 1000000);
    dio.options.receiveTimeout =  const Duration(milliseconds: 1000000);

    DateTime startTime = DateTime.now();
    dioPackage.Response response;

    try {
      response = await   dio.post(
        appBaseUrl! + uri!,
        data: jsonEncode(body),
      );
    } on  dioPackage.DioError catch (e) {
      if (e.type ==  dioPackage.DioErrorType.connectionTimeout || e.type ==  dioPackage.DioErrorType.receiveTimeout) {
        print("Request timeout");
        return Response(statusCode: 1, statusText: noInternetMessage);
      } else {
        print("Error: $e");
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    }

    DateTime endTime = DateTime.now();
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.data}");
    print("Request duration: ${endTime.difference(startTime).inSeconds} seconds");

    return handleResponseDio(response, uri);
  }

  Future<Response> postMultipartDataConversation(
      String? uri,
      Map<String, String> body,
      List<MultipartBody>? multipartBody,
      {Map<String, String>? headers,List<PlatformFile>? otherFile}) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
    request.headers.addAll(headers ?? _mainHeaders);

    if(otherFile != null ) {
      if(otherFile.isNotEmpty){
        for(PlatformFile platformFile in otherFile){
          request.files.add(http.MultipartFile('files[${otherFile.indexOf(platformFile)}]', platformFile.readStream!, platformFile.size, filename: basename(platformFile.name)));
        }
      }
    }
    if(multipartBody!=null){
      for(MultipartBody multipart in multipartBody) {
        Uint8List list = await multipart.file.readAsBytes();
        request.files.add(http.MultipartFile(
          multipart.key!, multipart.file.readAsBytes().asStream(), list.length, filename:'${DateTime.now().toString()}.png',
        ));
      }
    }
    request.fields.addAll(body);
    http.Response response = await http.Response.fromStream(await request.send());
    return handleResponse(response, uri);
  }

  Future<Response> postMultipartData(String? uri, Map<String, String> body, List<MultipartBody>? multipartBody, {Map<String, String>? headers}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
      request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody!) {
        if(kIsWeb) {
          Uint8List list = await multipart.file.readAsBytes();
          http.MultipartFile part = http.MultipartFile(
            multipart.key!, multipart.file.readAsBytes().asStream(), list.length,
            filename: basename(multipart.file.path), contentType: MediaType('images', 'jpg'),
          );
          request.files.add(part);
        }else {
          File file = File(multipart.file.path);
          request.files.add(http.MultipartFile(
            multipart.key!, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last,
          ));
        }
      }
      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    printLog('====> body : ${body.toString()}');
    try {
      http.Response response = await http.put(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String? uri, {Map<String, String>? headers}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String? uri) {

    dynamic body;
    try {
      body = jsonDecode(response.body);
    }catch(e) {
      if (kDebugMode) {
        print("");
      }
    }
    Response response0 = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(response0.statusCode != 200 && response0.body != null ) {
      print("response0.body is ");
      print(response0.body);
      if(response0.body.toString().startsWith('{response_code')) {
        ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: errorResponse.responseCode);
      }else if(response0.body.toString().startsWith('{message')) {
        response0 = Response(statusCode: response0.statusCode, body: response0.body, statusText: response0.body['message']);
      }else{
        print("response0.body is11111 ");
        print(response0.body);
      }
    }else if(response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(foundation.kDebugMode) {
      debugPrint('====> API Response: [${response0.statusCode}] $uri');
      //debugPrint('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    return response0;
  }


  Response handleResponseDio(dioPackage.Response response, String? uri) {
    dynamic body;

    try {
      body = jsonDecode(response.data);
    } catch (e) {
      if (kDebugMode) {
        print("Error decoding JSON: $e");
      }
    }

    Response response0 = Response(
      body: body ?? response.data,
      bodyString: response.data.toString(),
      request: Request(
        headers: _mainHeaders,
        method: response.requestOptions.method,
        url:Uri(path: response.requestOptions.path) ,
      ),
      // headers: response.headers.map,
      statusCode: response.statusCode,
      statusText: response.statusMessage,
    );

    if (response0.statusCode != 200 && response0.body != null) {
      print("response0.body is ");
      print(response0.body);

      if (response0.body.toString().startsWith('{response_code')) {
        ErrorsModel errorResponse = ErrorsModel.fromJson(response0.body);
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: errorResponse.responseCode,
        );
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
          statusCode: response0.statusCode,
          body: response0.body,
          statusText: response0.body['message'],
        );
      } else {
        print("response0.body is11111 ");
        print(response0.body);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }

    if (foundation.kDebugMode) {
      debugPrint('====> API Response: [${response0.statusCode}] $uri');
      //debugPrint('====> API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }

    return response0;
  }

}

class MultipartBody {
  String? key;
  XFile file;

  MultipartBody(this.key, this.file);
}