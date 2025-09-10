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
  String? lineid;
  String? graphPhoto;
  String? layingId;
  String? layingLength;
  String? layingDate;
  String? username;
  String? company;
  dynamic tpiApprovalSta;
  dynamic tpiApprovalLength;
  dynamic tpiApprovalDate;
  String? areaName;
  dynamic pmcApprovalLength;
  dynamic pmcApprovalSta;
  String? startPoint;
  dynamic pmcApprovalDate;
  dynamic zicApprovalLength;
  dynamic zicApprovalSta;
  dynamic zicApprovalDate;
  dynamic pmcApprovedBy;
  dynamic zicApprovedBy;
  String? endPoint;
  String? roadType;
  String? roadOwner;
  String? pipeSide;
  String? diameter;
  String? method;
  String? latitude;
  String? longitude;

  MdpePmcData({this.lineid,
        this.graphPhoto,
        this.layingId,
        this.layingLength,
        this.layingDate,
        this.username,
        this.company,
        this.tpiApprovalSta,
        this.tpiApprovalLength,
        this.tpiApprovalDate,
        this.areaName,
        this.pmcApprovalLength,
        this.pmcApprovalSta,
        this.startPoint,
        this.pmcApprovalDate,
        this.zicApprovalLength,
        this.zicApprovalSta,
        this.zicApprovalDate,
        this.pmcApprovedBy,
        this.zicApprovedBy,
        this.endPoint,
        this.roadType,
        this.roadOwner,
        this.pipeSide,
        this.diameter,
        this.method,
        this.latitude,
        this.longitude});

  MdpePmcData.fromJson(Map<String, dynamic> json) {
    lineid = json['lineid'] ?? "";
    graphPhoto = json['graph_photo'] ?? "";
    layingId = json['laying_id'] ?? "";
    layingLength = json['laying_length'] ?? "";
    layingDate = json['laying_date'] ?? "";
    username = json['username'] ?? "";
    company = json['company'] ?? "";
    tpiApprovalSta = json['tpi_approval_sta'] ?? "";
    tpiApprovalLength = json['tpi_approval_length'] ?? "";
    tpiApprovalDate = json['tpi_approval_date'] ?? "";
    areaName = json['area_name'] ?? "";
    pmcApprovalLength = json['pmc_approval_length'] ?? "";
    pmcApprovalSta = json['pmc_approval_sta'] ?? "";
    startPoint = json['start_point'] ?? "";
    pmcApprovalDate = json['pmc_approval_date'] ?? "";
    zicApprovalLength = json['zic_approval_length'] ?? "";
    zicApprovalSta = json['zic_approval_sta'] ?? "";
    zicApprovalDate = json['zic_approval_date'] ?? "";
    pmcApprovedBy = json['pmc_approved_by'] ?? "";
    zicApprovedBy = json['zic_approved_by'] ?? "";
    endPoint = json['end_point'] ?? "";
    roadType = json['road_type'] ?? "";
    roadOwner = json['road_owner'] ?? "";
    pipeSide = json['pipe_side'] ?? "";
    diameter = json['diameter'] ?? "";
    method = json['method'] ?? "";
    latitude = json['latitude'] ?? "";
    longitude = json['longitude'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lineid'] = this.lineid;
    data['graph_photo'] = this.graphPhoto;
    data['laying_id'] = this.layingId;
    data['laying_length'] = this.layingLength;
    data['laying_date'] = this.layingDate;
    data['username'] = this.username;
    data['company'] = this.company;
    data['tpi_approval_sta'] = this.tpiApprovalSta;
    data['tpi_approval_length'] = this.tpiApprovalLength;
    data['tpi_approval_date'] = this.tpiApprovalDate;
    data['area_name'] = this.areaName;
    data['pmc_approval_length'] = this.pmcApprovalLength;
    data['pmc_approval_sta'] = this.pmcApprovalSta;
    data['start_point'] = this.startPoint;
    data['pmc_approval_date'] = this.pmcApprovalDate;
    data['zic_approval_length'] = this.zicApprovalLength;
    data['zic_approval_sta'] = this.zicApprovalSta;
    data['zic_approval_date'] = this.zicApprovalDate;
    data['pmc_approved_by'] = this.pmcApprovedBy;
    data['zic_approved_by'] = this.zicApprovedBy;
    data['end_point'] = this.endPoint;
    data['road_type'] = this.roadType;
    data['road_owner'] = this.roadOwner;
    data['pipe_side'] = this.pipeSide;
    data['diameter'] = this.diameter;
    data['method'] = this.method;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
