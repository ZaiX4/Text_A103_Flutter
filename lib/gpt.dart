
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> get_gpt_text() async {
  var headers = {
    'Authorization': 'Bearer fk....',
    'User-Agent': 'Apifox/1.0.0 (https://apifox.com)',
    'Content-Type': 'application/json'
  };

  var request = http.Request('POST', Uri.parse('https://oa.api2d.net/v1/chat/completions'));
  request.body = json.encode({
    "model": "gpt-3.5-turbo",
    "messages": [
      {
        "role": "user",
        "content": "讲个笑话"
      }
    ],
    "safe_mode": false
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  }
  else {
    return response.reasonPhrase.toString();
  }

}