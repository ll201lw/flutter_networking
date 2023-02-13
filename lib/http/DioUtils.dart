



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'BaseResponse.dart';

int _connectTimeOut = 15;
int _recieveTimeOut = 15;
int _sendTimeOut = 15;
String _baseUrl = "";
List<Interceptor> _interceptors = [];


typedef SuccessCallback<T> = Function(T data);
typedef SuccessListCallback<T> = Function(List<T> data);
typedef ErrorCallback = Function(int code,String msg);


class DioUtils{

  factory DioUtils() => _singleTon;

  static final DioUtils _singleTon = DioUtils._();

  static DioUtils get instacne => DioUtils();

  static late Dio _dio;

  Dio get dio =>_dio;

  DioUtils._(){
    final BaseOptions options = BaseOptions(
      connectTimeout: _connectTimeOut,
      receiveTimeout: _recieveTimeOut,
      sendTimeout: _sendTimeOut,
      responseType: ResponseType.json,
      validateStatus: (_){
        return true;
      },
      baseUrl: _baseUrl,
    );

    _dio = Dio(options);

    void addInterceptor(Interceptor interceptor){
      _dio.interceptors.add(interceptor);
    }
    _interceptors.forEach(addInterceptor);
  }

  Future<BaseResponse<T>> _request<T>(String method,String url,{
    Object? data,
    Map<String,dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  })async{
    final Response<String> response = await _dio.request<String>(
      url,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions(options!, method),
      cancelToken: cancelToken
    );
    try{
      final String data = response.data.toString();
      final bool isCompute = data.length > 10 * 1024;
      final Map<String,dynamic> map = isCompute ? await compute(parseData,data):parseData(data);
      return BaseResponse<T>.fromJson(map);
    }catch(e){
      return BaseResponse<T>(1001,"解析出错!",null);
    }
  }

  checkOptions(Options options,String method){
    options ??= Options();
    options.method = method;
    return options;
  }

}


Map<String,dynamic> parseData(String data){
  return json.decode(data) as Map<String,dynamic>;
}

enum Method{
  get,
  post,
  put,
  patch,
  delete,
  head
}

extension MethodExtension on Method{
  String get value => ['GET','POST','PUT','PATCH','DELETE','HEAD'][index];
}