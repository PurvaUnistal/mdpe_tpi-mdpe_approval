class GetMdpePmcDataModel {
  int? success;
  bool? error;
  dynamic data;

  GetMdpePmcDataModel({this.success, this.error, this.data});

  GetMdpePmcDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = <MdpePmcData>[];
      json['data'].forEach((v) {
        data!.add(new MdpePmcData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MdpePmcData {
  String? mdpeid;
  String? layingId;
  String? layingLength;
  String? username;
  String? company;
  String? wbs;
  String? pmcApprovalLength;
  String? pmcApprovalSta;
  String? startPoint;
  String? endPoint;
  String? roadType;
  String? roadOwner;
  String? pipeSide;
  String? diameter;
  String? method;

  MdpePmcData(
      {this.mdpeid,
        this.layingId,
        this.layingLength,
        this.username,
        this.company,
        this.wbs,
        this.pmcApprovalLength,
        this.pmcApprovalSta,
        this.startPoint,
        this.endPoint,
        this.roadType,
        this.roadOwner,
        this.pipeSide,
        this.diameter,
        this.method});

  MdpePmcData.fromJson(Map<String, dynamic> json) {
    mdpeid = json['mdpeid'] ?? "";
    layingId = json['laying_id'] ?? "";
    layingLength = json['laying_length'] ?? "";
    username = json['username'] ?? "";
    company = json['company'] ?? "";
    wbs = json['wbs'] ?? "";
    pmcApprovalLength = json['pmc_approval_length'] ?? "";
    pmcApprovalSta = json['pmc_approval_sta'] ?? "";
    startPoint = json['start_point'] ?? "";
    endPoint = json['end_point'] ?? "";
    roadType = json['road_type'] ?? "";
    roadOwner = json['road_owner'] ?? "";
    pipeSide = json['pipe_side'] ?? "";
    diameter = json['diameter'] ?? "";
    method = json['method'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mdpeid'] = this.mdpeid;
    data['laying_id'] = this.layingId;
    data['laying_length'] = this.layingLength;
    data['username'] = this.username;
    data['company'] = this.company;
    data['wbs'] = this.wbs;
    data['pmc_approval_length'] = this.pmcApprovalLength;
    data['pmc_approval_sta'] = this.pmcApprovalSta;
    data['start_point'] = this.startPoint;
    data['end_point'] = this.endPoint;
    data['road_type'] = this.roadType;
    data['road_owner'] = this.roadOwner;
    data['pipe_side'] = this.pipeSide;
    data['diameter'] = this.diameter;
    data['method'] = this.method;
    return data;
  }
}
