

class PicCodeEntity{
  String? img = "";
  String? uuid = "";

  PicCodeEntity({this.img,this.uuid});

  factory PicCodeEntity.fromJson(Map<String,dynamic> json){
    PicCodeEntity picCodeEntity = PicCodeEntity();
    picCodeEntity.img = json["img"];
    picCodeEntity.uuid = json["uuid"];
    return picCodeEntity;
  }
}