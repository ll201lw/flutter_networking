import 'package:flutter_networking/login/PicCodeEntity.dart';


JsonConvert jsonConvert = JsonConvert();

class JsonConvert {

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }
  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type ==  "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type ==  "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return JsonConvert.fromJsonAsT<T>(value);
      }
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return null;
    }
  }
  //Go back to a single instance by type
  static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
      M m = PicCodeEntity.fromJson(json) as M;
      return m;
  }

  //list is returned by type
  static M? _getListChildType<M>(List<dynamic> data) {
    if(<PicCodeEntity>[] is M){
      return data.map<PicCodeEntity>((e) => PicCodeEntity.fromJson(e)).toList() as M;
    }
    return null;
  }

  static M? fromJsonAsT<M>(dynamic data) {
    if(data == null){
      return null;
    }
    if (data is List) {
      return _getListChildType<M>(data);
    } else {
      return _fromJsonSingle<M>(data as Map<String, dynamic>);
    }
  }
}