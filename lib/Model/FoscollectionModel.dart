class FoscollectionModel {
  bool? status;
  String? message;
  List<CollectionData>? data;

  FoscollectionModel({this.status, this.message, this.data});

  FoscollectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CollectionData>[];
      json['data'].forEach((v) {
        data!.add(new CollectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionData {
  String? id;
  String? userId;
  String? amount;
  String? fosId;
  String? remarks;
  String? addedBy;
  String? status;
  String? createdAt;
  String? updateAt;
  String? statusText;

  CollectionData(
      {this.id,
        this.userId,
        this.amount,
        this.fosId,
        this.remarks,
        this.addedBy,
        this.status,
        this.createdAt,
        this.updateAt,
        this.statusText});

  CollectionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    fosId = json['fos_id'];
    remarks = json['remarks'];
    addedBy = json['added_by'];
    status = json['status'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['fos_id'] = this.fosId;
    data['remarks'] = this.remarks;
    data['added_by'] = this.addedBy;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['status_text'] = this.statusText;
    return data;
  }
}
