import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chatgpt_integration/constants/api_consts.dart';
import 'package:chatgpt_integration/models/chat_model.dart';
import 'package:chatgpt_integration/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {"Authorization": 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
      }
      print("jsonResponse $jsonResponse");
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("error is $error");
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/chat/completions"),
          headers: {
            "Authorization": 'Bearer $API_KEY',
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": modelId,
            "messages": [
              {"role": "user", "content": message}
            ],
            "temperature": 0.7
          }));

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // Access the content from the first choice
        String content = jsonResponse["choices"][0]["message"]["content"];
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                msg: jsonResponse["choices"][index]["message"]["content"],
                chatIndex: 1));
        print('The content is: $content');
      }
      return chatList;

      // Handle the rest of the response as needed
    } catch (error) {
      print("Error: $error");
      rethrow;
    }
  }
}
