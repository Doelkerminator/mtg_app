
import 'dart:convert';

import 'package:mtg_app/Models/MagicCard.dart';
import 'package:http/http.dart' as http;

class ApiCards {
  static Future<List<MagicCard>?> getAllCards(String name) async {
    var URL = Uri.parse(
      'https://api.magicthegathering.io/v1/cards?pageSize=70&name=$name');
    var response = await http.get(URL);
    print(response.body);
    if (response.statusCode == 200) {
      var cards = jsonDecode(response.body)['cards'] as List;
      List<MagicCard> magicCards = [];
      for (var card in cards) {
        if(card['multiverseid'] != null) {
          magicCards.add(MagicCard.fromMap(card));
        }
      }
      return magicCards;
    }
    else {
      return null;
    }
  }

  static Future<MagicCard?> getCard(String multiverseid) async {
    var URL = Uri.parse(
      'https://api.magicthegathering.io/v1/cards/$multiverseid');
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      print(response.body);
      var card = jsonDecode(response.body)['card'];
      return MagicCard.fromMap(card);
    }
    else {
      return null;
    }
  }
}