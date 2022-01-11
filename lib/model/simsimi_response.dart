

class SimsimiResponse {
  int? status;
  String? statusMessage;
  String? atext;
  String? lang;
  Request? request;

  SimsimiResponse(
      {this.status, this.statusMessage, this.atext, this.lang, this.request});

  SimsimiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['statusMessage'];
    atext = json['atext'];
    lang = json['lang'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusMessage'] = this.statusMessage;
    data['atext'] = this.atext;
    data['lang'] = this.lang;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class Request {
  String? utext;
  String? lang;

  Request({this.utext, this.lang});

  Request.fromJson(Map<String, dynamic> json) {
    utext = json['utext'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['utext'] = this.utext;
    data['lang'] = this.lang;
    return data;
  }
}