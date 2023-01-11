import 'dart:convert';

import 'package:http/http.dart' as http;

//Model Class of the Quote
//First, I created a Quote class that contains the data from the network request.
//It includes a factory constructor that creates a Quote from JSON.
class QuoteModel {
  Slip? slip;

  QuoteModel({this.slip});

  QuoteModel.fromJson(Map<String, dynamic> json) {
    slip = json['slip'] != null ? Slip.fromJson(json['slip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (slip != null) {
      data['slip'] = slip!.toJson();
    }
    return data;
  }
}

class Slip {
  int? id;
  String? advice;

  Slip({this.id, this.advice});

  Slip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advice'] = advice;
    return data;
  }
}

//Convert the response body into a JSON Map with the dart:convert package.
//If the server does return an OK response with a status code of 200, then convert the JSON Map into a Quote using the fromJson() factory method.
//If the server does not return an OK response with a status code of 200, then throw an exception.
Future<QuoteModel> fetchQuote() async {
  final response =
      await http.get(Uri.parse('https://api.adviceslip.com/advice'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return QuoteModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load quote');
  }
}
