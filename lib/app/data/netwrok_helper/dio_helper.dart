// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:notes/app/data/netwrok_helper/strings.dart';
import 'package:get/get.dart' as getx;

import '../../constants/links.dart';
import '../../global_presentation/global_widgets/custom_snack_bar.dart';
import 'api_exception.dart';

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Links.baseLink,
      receiveDataWhenStatusError: true,
    ),
  );

  static const int TIME_OUT_DURATION = 10;

  static post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function(int total, int progress)?
        onReceiveProgress, // while receiving data(response)
    Function? onLoading,
    dynamic data,
  }) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await _dio.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: Options(
            headers: headers,
            //   receiveTimeout: TIME_OUT_DURATION,
            sendTimeout: TIME_OUT_DURATION),
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection

      log("onError $onError");
      if (error.message.toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: Strings.noInternetConnection.tr,
              url: Links.baseLink + url,
            )) ??
            _handleError(Strings.noInternetConnection.tr);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: Links.baseLink + url,
          message: error.message,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: Strings.serverError.tr,
          url: Links.baseLink + url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception = ApiException(
        message: error.response!.data["message"] ?? error.message,
        url: Links.baseLink + url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      log("No internet connection");
      onError?.call(ApiException(
            message: Strings.noInternetConnection.tr,
            url: Links.baseLink + url,
          )) ??
          _handleError(Strings.noInternetConnection.tr);
    } on TimeoutException {
      // Api call went out of time
      log("Api call went out of time");
      onError?.call(ApiException(
            message: Strings.serverNotResponding.tr,
            url: Links.baseLink + url,
          )) ??
          _handleError(Strings.serverNotResponding.tr);
    } catch (error) {
      // unexpected error for example (parsing json error)
      log("unexpected error for example (parsing json error)");
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  // GET request
  static get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    required Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function? onLoading,
  }) async {
    _dio.interceptors.add(dioLoggerInterceptor);

    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await _dio
          .get(
            url,
            onReceiveProgress: onReceiveProgress,
            queryParameters: queryParameters,
            options: Options(
              headers: headers,
            ),
          )
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      await onSuccess(response);
    } on DioError catch (error) {
      log("Dio Error");
      if (error.message.toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: Strings.noInternetConnection,
              url: url,
            )) ??
            _handleError(Strings.noInternetConnection);
      }
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: Strings.serverError,
          url: url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }
    } on SocketException {
      log("SocketException");

      onError?.call(ApiException(
            message: Strings.noInternetConnection,
            url: url,
          )) ??
          _handleError(Strings.noInternetConnection);
    } on TimeoutException {
      log("SocketException");

      onError?.call(ApiException(
            message: Strings.serverNotResponding,
            url: url,
          )) ??
          _handleError(Strings.serverNotResponding);
    }
    // catch (error) {
    //   onError?.call(ApiException(
    //         message: error.toString(),
    //         url: url,
    //       )) ??
    //       _handleError(error.toString());
    // }
  }

  // PUT request
  static put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int total, int progress)?
        onSendProgress, // while sending (uploading) progress
    Function(int total, int progress)?
        onReceiveProgress, // while receiving data(response)
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await _dio.put(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        queryParameters: queryParameters,
        options: Options(
            headers: headers,
            receiveTimeout: TIME_OUT_DURATION,
            sendTimeout: TIME_OUT_DURATION),
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message.toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: Strings.noInternetConnection.tr,
              url: url,
            )) ??
            _handleError(Strings.noInternetConnection.tr);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: Strings.serverError.tr,
          url: url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception = ApiException(
        message: error.message,
        url: url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(
            message: Strings.noInternetConnection.tr,
            url: url,
          )) ??
          _handleError(Strings.noInternetConnection.tr);
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(
            message: Strings.serverNotResponding.tr,
            url: url,
          )) ??
          _handleError(Strings.serverNotResponding.tr);
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  // DELETE request
  static delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      // 1) indicate loading state
      onLoading?.call();
      // 2) try to perform http request
      var response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
            headers: headers,
            receiveTimeout: TIME_OUT_DURATION,
            sendTimeout: TIME_OUT_DURATION),
      );
      // 3) return response (api done successfully)
      await onSuccess.call(response);
    } on DioError catch (error) {
      // dio error (api reach the server but not performed successfully
      // no internet connection
      if (error.message.toLowerCase().contains('socket')) {
        onError?.call(ApiException(
              message: Strings.noInternetConnection.tr,
              url: url,
            )) ??
            _handleError(Strings.noInternetConnection.tr);
      }

      // no response
      if (error.response == null) {
        var exception = ApiException(
          url: url,
          message: error.message,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      // check if the error is 500 (server problem)
      if (error.response?.statusCode == 500) {
        var exception = ApiException(
          message: Strings.serverError.tr,
          url: url,
          statusCode: 500,
        );
        return onError?.call(exception) ?? handleApiError(exception);
      }

      var exception = ApiException(
        message: error.message,
        url: url,
        statusCode: error.response?.statusCode ?? 404,
      );
      return onError?.call(exception) ?? handleApiError(exception);
    } on SocketException {
      // No internet connection
      onError?.call(ApiException(
            message: Strings.noInternetConnection.tr,
            url: url,
          )) ??
          _handleError(Strings.noInternetConnection.tr);
    } on TimeoutException {
      // Api call went out of time
      onError?.call(ApiException(
            message: Strings.serverNotResponding.tr,
            url: url,
          )) ??
          _handleError(Strings.serverNotResponding.tr);
    } catch (error) {
      // unexpected error for example (parsing json error)
      onError?.call(ApiException(
            message: error.toString(),
            url: url,
          )) ??
          _handleError(error.toString());
    }
  }

  /// download file
  static download(
      {required String url, // file url
      required String savePath, // where to save file
      Function(ApiException)? onError,
      Function(int value, int progress)? onReceiveProgress,
      required Function onSuccess}) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(receiveTimeout: 999999, sendTimeout: 999999),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      var exception = ApiException(url: url, message: error.toString());
      onError?.call(exception) ?? _handleError(error.toString());
    }
  }

  static handleApiError(ApiException apiException) {
    if (getx.Get.isDialogOpen!) {
      getx.Get.back();
    }
    String msg =
        apiException.response?.data?['message'] ?? apiException.message;
    log("msg1  $msg");
    CustomSnackBar.showCustomErrorSnackBar(message: msg, title: "Error");
  }

  static _handleError(String msg) {
    if (getx.Get.isDialogOpen!) {
      getx.Get.back();
    }
    log("msg2  $msg");

    CustomSnackBar.showCustomErrorSnackBar(message: msg, title: "Error");
  }
}

final dioLoggerInterceptor =
    InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
  String headers = "";
  options.headers.forEach((key, value) {
    headers += "| $key: $value";
  });

  log("┌------------------------------------------------------------------------------");
  log('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
  log("├------------------------------------------------------------------------------");
  handler.next(options); //continue
}, onResponse: (Response response, handler) async {
  log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
  log("└------------------------------------------------------------------------------");
  handler.next(response);
  // return response; // continue
}, onError: (DioError error, handler) async {
  log("| [DIO] Error: ${error.error}: ${error.response.toString()}");
  log("└------------------------------------------------------------------------------");
  handler.next(error); //continue
});
