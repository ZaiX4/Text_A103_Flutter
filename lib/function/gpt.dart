
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> get_gpt_text(String message) async {
  var headers = {
    'Authorization': 'Bearer fk213655-B4BA0Go0HuPYSwS5fI9Xbx7N9TNDMMvT',
    'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
    'Content-Type': 'application/json'
  };

  var request = http.Request('POST', Uri.parse('https://oa.api2d.net/v1/chat/completions'));
  request.body = json.encode({
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "user",
        "content": message
      }
    ],
    "safe_mode": false
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var ss = await response.stream.bytesToString();
    return json.decode(ss)['choices'][0]['message']['content'].toString();
  }
  else {
    return response.reasonPhrase.toString();
  }

}