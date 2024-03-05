import 'dart:convert';

import 'package:http/http.dart' as http;

class SocketRepository {
  sendMessage(String message) async {
    try {
      var response = await http.post(
          Uri.parse('http://10.0.2.2:8080/api/websocket/send-message'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "id": "1",
            "message": message.toString().trim(),
            "role": "admin"
          }));
      return jsonDecode(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
