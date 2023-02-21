class MachineEntity {
  String? id;
  String? companyId;
  String? machineryId;
  String? machineryCode;
  String? machineryName;
  String? machineryCategoryName;
  String? machineryCategoryCode;
  String? vin;
  String? image;
  String? implementsId;
  String? implementsCode;
  String? implementsName="测试机具";
  Object? implementsCategoryCode;
  String? implementsSymbol;
  String? implementsTypeName;
  int? combinationType;
  String? combinationTypeName="测试";
  int? faultStatus;
  String? terminalCode;
  int? terminalStatus;
  double? remainingOil;
  int? status;
  bool? deleted;
  String? currentLongitude;
  String? currentLatitude;
  Object? createTime;
  Object? updateTime;
  Object? createUserId;
  Object? updateUserId;
  int? taskStatus;
  String? taskFeild;
  int? taskType;
  double? taskProgress;
  String? taskStartTime;
  double? remainingTime;
  String? taskId;
  bool? completeConfig;
  int? signal = -1;
  bool? isSelected = false;

  MachineEntity({this.image});

  factory MachineEntity.fromJson(Map<String, dynamic> json) {
    MachineEntity machineEntity = MachineEntity();
    machineEntity.image = json["image"];
    machineEntity.terminalCode = json["terminalCode"];
    machineEntity.terminalStatus = json["terminalStatus"];
    machineEntity.taskStatus = json["taskStatus"];
    machineEntity.machineryName = json["machineryName"];
    machineEntity.machineryId = json["machineryId"];
    machineEntity.machineryCategoryName = json["machineryCategoryName"];
    machineEntity.machineryCode = json["machineryCode"];
    machineEntity.machineryCategoryCode = json["machineryCategoryCode"];

    machineEntity.implementsId = json["implementsId"];
    machineEntity.implementsName = json["implementsName"];
    machineEntity.implementsSymbol = json["implementsSymbol"];
    machineEntity.implementsTypeName = json["implementsTypeName"];

    machineEntity.combinationTypeName = json["combinationTypeName"];

    machineEntity.taskFeild = json["taskFeild"];
    machineEntity.taskType = json["taskType"];
    return machineEntity;
  }
}
