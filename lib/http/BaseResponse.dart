import '../constant/Constant.dart';



class BaseResponse<T>{

  int? code;
  late String message;
  T? data;

  BaseResponse(this.code,this.message,this.data);


  BaseResponse.fromJson(Map<String,dynamic> json){
    code = json[Constant.code] as int?;
    message = json[Constant.message] as String;
    if(json.containsKey(Constant.data)){
      data = _parseToObj<T>(json[Constant.data] as Object?);
    }
  }

  T? _parseToObj<O>(Object? json){
    if(json == null){
      return null;
    }
    if(T.toString() == 'String'){
      return json.toString() as T;
    }else if(T.toString() == 'Map<danamic,danamic>'){
      return json as T;
    }
    return null;
    // else{
    //   return JsonConver.fromJsonAsT<T>(json);
    // }
  }

}