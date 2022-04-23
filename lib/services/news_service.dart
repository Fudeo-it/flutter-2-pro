import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/models/everything_response.dart';

class NewsService {
  Future<EverythingResponse> everything() async {
    final response = await http
        .get(Uri.parse('https://newsapi.org/v2/everything?q=italy'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer <token>' //TODO
    });

    if (response.statusCode == 200) {
      return EverythingResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Can\'t load everything response');
    }
  }
}
