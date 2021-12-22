import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_search/data/repository/stocks_search_repository.dart';

class StocksSearchEntity {
  Future<List<StocksModel>> getStockEntity() async {
    final result = await StocksSearchRepository.fethStocks();
    return List<StocksModel>.from(
      result.map((x) => StocksModel.fromJson(x)),
    );
  }
}
