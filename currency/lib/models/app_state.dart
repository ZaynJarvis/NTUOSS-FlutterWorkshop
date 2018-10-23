import 'package:meta/meta.dart';

@immutable
class AppState {
  final String baseCountry;
  final Map countryMap;
  final String price;

  AppState({
    this.baseCountry = '',
    this.countryMap = const {},
    this.price = '',
  });

  AppState copyWith({
    String baseCountry,
    Map countryMap,
    String price,
  }) {
    return AppState(
      baseCountry: baseCountry ?? this.baseCountry,
      countryMap: countryMap ?? this.countryMap,
      price: price ?? this.price,
    );
  }

  // computing hash codes is something like compressing equality to an integer value: Equal objects must have the same hash code and for performance reasons it is best if as few non-equal objects as possible share the same hash.
  @override
  int get hashCode =>
      baseCountry.hashCode ^ countryMap.hashCode ^ price.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          baseCountry == this.baseCountry &&
          countryMap == this.countryMap &&
          price == this.price;

  @override
  String toString() {
    return 'AppState{baseCountry: $baseCountry, countryMap: $countryMap, price: $price}';
  }
}
