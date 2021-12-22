import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_watched/data/entity/stocks_watched_entity.dart';

part 'stocks_watched_fetcher_state.dart';

class StocksWatchedFetcherCubit extends Cubit<StocksWatchedFetcherState> {
  final StocksWatchedEntity _stocksWatchedEntity;
  StocksWatchedFetcherCubit(this._stocksWatchedEntity) : super(StocksWatchedFetcherInitial());

  fetchWatchedStock(String collectionId, {bool isRefresh = false}) async {
    try {
      if (!isRefresh) emit(StocksWatchedFetcherLoading());
      final result = await _stocksWatchedEntity.getStockWatchedEntity(collectionId);
      if (result != null) {
        emit(StocksWatchedFetcherLoaded(result));
      } else {
        emit(StocksWatchedFetcherFailure('gagal'));
      }
    } catch (e) {
      emit(StocksWatchedFetcherFailure('gagal*'));
    }
  }

  removeWatchedStocks(String collectionId, String documentId) async {
    try {
      await StocksWatchedEntity().deleteWatchedEntity(collectionId, documentId);
      fetchWatchedStock(collectionId, isRefresh: true);
    } catch (e) {
      emit(StocksWatchedFetcherFailure('gagal*'));
    }
  }
}
