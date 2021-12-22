import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_watched/data/repository/stocks_watch_repository.dart';

class StocksWatchedEntity {
  Future<List<StocksModel>> getStockWatchedEntity(String collectionId) async {
    List<StocksModel> listStocks = [];
    QuerySnapshot result = await StocksWatchedRepository().fethStocksWatched(collectionId);
    result.docs.forEach((e) {
      listStocks.add(StocksModel(
        currency: '${(e.data())["currency"]}',
        description: '${(e.data())["description"]}',
        displaySymbol: '${(e.data())["displaySymbol"]}',
        figi: '${(e.data())["figi"]}',
        mic: '${(e.data())["mic"]}',
        symbol: '${(e.data())["symbol"]}',
        type: '${(e.data())["type"]}',
        documentId: e.id,
      ));
    });
    return listStocks;
  }

  Future<void> addStockWatchedEntity(String collectionId, StocksModel stocks) async {
    await StocksWatchedRepository().addStocksWatched(collectionId, stocks);
  }

  Future<void> deleteWatchedEntity(String collectionId, String documentId) async {
    await StocksWatchedRepository().deleteStocksWatched(collectionId, documentId);
  }
}
