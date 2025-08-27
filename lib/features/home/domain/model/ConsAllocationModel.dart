class ConsAllocationModel {
  int? success;
  bool? error;
  List<AllocationData>? data;

  ConsAllocationModel({this.success, this.error, this.data});

  ConsAllocationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    if (json['data'] != null) {
      data = <AllocationData>[];
      json['data'].forEach((v) {
        data!.add(new AllocationData.fromJson(v));
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

class AllocationData {
  String? assignTo;
  String? contractId;
  String? allocationNumber;
  String? wbsNo;

  AllocationData({this.assignTo, this.contractId, this.allocationNumber, this.wbsNo});

  AllocationData.fromJson(Map<String, dynamic> json) {
    assignTo = json['assign_to'];
    contractId = json['contract_id'];
    allocationNumber = json['allocation_number'];
    wbsNo = json['wbs_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assign_to'] = this.assignTo;
    data['contract_id'] = this.contractId;
    data['allocation_number'] = this.allocationNumber;
    data['wbs_no'] = this.wbsNo;
    return data;
  }
}
