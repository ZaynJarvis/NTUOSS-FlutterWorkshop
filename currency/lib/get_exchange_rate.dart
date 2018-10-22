import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String currencyAPI =
    'http://data.fixer.io/api/latest?access_key=848680d4b0eaee2e313344d4343010aa';

final String countryAPI = 'https://restcountries.eu/rest/v2/name/';

Future<Map> getExchangeRate(countryAlias) async {
  try {
    final newCountry = await http.get(Uri.encodeFull(countryAPI + countryAlias),
        headers: {"Accept": "application/json"});
    String newConturyName = jsonDecode(newCountry.body)[0]['name'];
    String newConturyCode =
        jsonDecode(newCountry.body)[0]['currencies'][0]['code'];
    var response = await http.get(Uri.encodeFull(currencyAPI),
        headers: {"Accept": "application/json"});
    double currency = jsonDecode(response.body)['rates'][newConturyCode];
    return {newConturyName: currency};
  } catch (e) {
    return {};
  }
}
