import 'package:flutter_networking/utils/json/JsonConvert.dart';

import '../../constant/Constant.dart';



class BaseResponse{

  int? status;
  late String message;
  Object? result;

  BaseResponse(this.status,this.message,this.result);


  BaseResponse.fromJson(Map<String,dynamic> json){
    if(null == json){
      result = "";
    }
    status = json[Constant.code] as int?;
    message = json[Constant.message] as String;
    if(json.containsKey(Constant.data)){
      result = json[Constant.data];
    }
  }

  Object? _parseToObj(Object? data){
    if(data == null){
      return null;
    }
    return data;
  }

}