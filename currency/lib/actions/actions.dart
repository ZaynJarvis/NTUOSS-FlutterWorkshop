class RestoreFromDatabaseAction {}

class DatabaseLoadedAction {
  final String baseCountry;
  final Map countryMap;
  DatabaseLoadedAction({this.baseCountry, this.countryMap});
}

class UpdateBaseCountryAction {
  final String baseCountry;
  UpdateBaseCountryAction(this.baseCountry);
}

class AddCountryMapAction {
  final Map countryRecord;
  AddCountryMapAction(this.countryRecord);
}

class RemoveCountryAction {
  final String countryName;
  RemoveCountryAction(this.countryName);
}

class UpdatePriceAction {
  final String price;
  UpdatePriceAction(this.price);
}
