//zW8VqEvIAyAMinyxTNurJ6..bq8bPLfDB-SsSX~J
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:simsimi_app/model/simsimi_response.dart';

Future<String> fetchSimsimiAPI(String message, String lang) async {
  const uri = 'https://wsapi.simsimi.com/190410/talk';
  const key = 'zW8VqEvIAyAMinyxTNurJ6..bq8bPLfDB-SsSX~J';

  var body = {'utext': message, 'lang': lang};
  var res = await http.post(Uri.parse(uri),
      headers: {
        "Content-Type": " application/json",
        "x-api-key": key,
      },
      body: jsonEncode(body));

  if (res.statusCode == 200) {
    var response = SimsimiResponse.fromJson(json.decode(res.body));
    return response.atext!;
  } else {
    log('message${res.statusCode}');
    return 'Error';
  }
}
