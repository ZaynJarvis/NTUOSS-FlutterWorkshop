import 'package:redux/redux.dart';
import 'package:currency/actions/actions.dart';

final priceReducer = combineReducers<String>([
  TypedReducer<String, UpdatePriceAction>(_updatePriceReducer),
]);

String _updatePriceReducer(String price, UpdatePriceAction action) {
  return action.price;
}
