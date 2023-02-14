import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_networking/constant/Constant.dart';
import 'package:flutter_networking/httpapi/HttpHeader.dart';
import 'BaseResponse.dart';
import 'error_handle.dart';

int _connectTimeOut = 15000;
int _recieveTimeOut = 15000;
int _sendTimeOut = 15000;
String _baseUrl = "";
List<Interceptor> _interceptors = [];

typedef SuccessCallback<T> = Function(Object? data);
typedef SuccessListCallback<T> = Function(List<Object>? data);
typedef ErrorCallback = Function(int code, String msg);

class DioUtils {
  factory DioUtils() => _singleTon;

  static final DioUtils _singleTon = DioUtils._();

  static DioUtils get instacne => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  DioUtils._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeOut,
      receiveTimeout: _recieveTimeOut,
      sendTimeout: _sendTimeOut,
      responseType: ResponseType.json,
      headers: HttpHeader.headers(),
      validateStatus: (_) {
        return true;
      },
      baseUrl: Constant.networkUrl,
    );

    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor());

    void addInterceptor(Interceptor interceptor) {
      _dio.interceptors.add(interceptor);
    }

    _interceptors.forEach(addInterceptor);
  }

  Future<BaseResponse> _request(
    String method,
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Map<String, dynamic>? header,
    Options? options,
  }) async {
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions(options, method, header),
      cancelToken: cancelToken,
    );
    // print("response=>${response.data}");
    try {
      final String data = response.data.toString();
      final bool isCompute = data.length > 10 * 1024;
      final Map<String, dynamic> map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseResponse.fromJson(map);
    } catch (e) {
      print("response=>${e.toString()}");
      return BaseResponse(1001, "解析出错!", null);
    }
  }

  Future<dynamic> request<T>(
    Method method,
    String url, {
    SuccessCallback<Object?>? onSuccess,
    ErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParammeters,
    CancelToken? cancelToken,
    Map<String, dynamic>? header,
    Options? options,
  }) {
    return _request(method.value, url,
        data: params,
        queryParameters: queryParammeters,
        header: header,
        options: options,
        cancelToken: cancelToken)
      ..then<void>((BaseResponse result) {
        if (result.status == 200) {
          onSuccess?.call(result.result);
        } else {
          _onError(result.status, result.message, onError);
        }
      }, onError: (dynamic e) {
        final NetError error = ExceptionHandle.handleException(e);
        _onError(error.code, error.msg, onError);
      });
  }

  checkOptions(Options? options, String method, Map<String, dynamic>? header) {
    options ??= Options();
    options.method = method;
    options.headers = header;
    return options;
  }

  void _onError(int? code, String msg, ErrorCallback? onError) {
    if (code == null) {
      code = 9999;
      msg = '未知异常';
    }
    // Log.e('接口请求异常： code: $code, mag: $msg');
    onError?.call(code, msg);
  }

  Future<dynamic> requestNetwork<Object>(
    Method method,
    String url, {
    String? baseUrl,
    SuccessCallback<Object?>? onSuccess,
    ErrorCallback? onError,
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Map<String, dynamic>? header,
    Options? options,
  }) {
    return _request(
      method.value,
      url,
      data: params,
      queryParameters: queryParameters,
      header: header,
      options: options,
      cancelToken: cancelToken,
    ).then<void>((BaseResponse result) {
      if (result.status == 200) {
        onSuccess?.call(result.result);
      } else {
        _onError?.call(result.status, result.message, onError);
      }
    }, onError: (dynamic e) {
      final NetError error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }
}

String getUrl(String baseUrl, BaseUrlType baseUrlType) {
  String url = "";
  if (baseUrlType.index == 0) {
    url = Constant.networkUrl;
  } else if (baseUrlType.index == 1) {
    url = Constant.networkUrl;
  } else if (baseUrlType.index == 2) {
    url = Constant.networkUrl;
  }
  return url;
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}

enum BaseUrlType {
  main,
  bmap,
  gis,
}

enum Method { get, post, put, patch, delete, head }

extension MethodExtension on Method {
  String get value => ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'][index];
}
