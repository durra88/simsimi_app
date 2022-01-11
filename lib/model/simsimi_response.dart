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
        json['request'] != null ? Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['statusMessage'] = statusMessage;
    data['atext'] = atext;
    data['lang'] = lang;
    if (request != null) {
      data['request'] = request!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['utext'] = utext;
    data['lang'] = lang;
    return data;
  }
}
