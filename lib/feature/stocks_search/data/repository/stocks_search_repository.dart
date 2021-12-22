import 'package:dio/dio.dart';
import 'package:excercise_stocks/helper/constant.dart';

class StocksSearchRepository {
  static Future<dynamic> fethStocks() async {
    final response = await Dio().get(
      Constant.BASE_URL + Constant.STOCK_SYMBOL,
      queryParameters: {
        'token': Constant.FINNHUB_API_KEY,
        'exchange': 'JK',
        'currency': 'IDR',
        'mic': 'XIDX',
      },
    );
    return response.data;
  }
}
