import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';

class StocksWatchedRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<dynamic> fethStocksWatched(String collectionId) async {
    return await firestore.collection(collectionId).get();
  }

  Future<void> addStocksWatched(String collectionId, StocksModel stocks) async {
    await firestore.collection(collectionId).add(stocks.toJson());
  }

  Future<void> deleteStocksWatched(String collectionId, String documentId) async {
    await firestore.collection(collectionId).doc(documentId).delete();
  }
}
