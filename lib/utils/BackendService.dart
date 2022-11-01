import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    if (query.isEmpty && query.length < 3) {
      print('Query needs to be at least 3 chars');
      return Future.value([]);
    }
    var url = Uri.https('goetc.in', '/API/ServicesAPI/GetSocietiesAutoSerach', {'DSearch': query});
    var response = await http.get(url);
    List<Suggestion> suggestions = [];
    if (response.statusCode == 200) {
      Iterable json = convert.jsonDecode(response.body)['SocietiesList'];
      suggestions =
      List<Suggestion>.from(json.map((model) => Suggestion.fromJson(model)));

      print('Number of suggestion: ${suggestions.length}.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return Future.value(suggestions
        .map((e) => {'Name': e.Name, 'SocietyId': e.SocietyId.toString()})
        .toList());
  }
}

class Suggestion {
  final int SocietyId;
  final String Name;

  Suggestion({
    required this.SocietyId,
    required this.Name,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      Name: json['Name'],
      SocietyId: json['SocietyId'],
    );
  }
}