import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excercise_stocks/feature/stocks_search/data/entity/stocks_search_entity.dart';
import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_watched/data/entity/stocks_watched_entity.dart';
import 'package:flutter/foundation.dart';

part 'stocks_fetcher_state.dart';

class StocksFetcherCubit extends Cubit<StocksFetcherState> {
  final StocksSearchEntity _stocksEntity;
  final StocksWatchedEntity _stocksWatchedEntity;
  StocksFetcherCubit(this._stocksEntity, this._stocksWatchedEntity) : super(StocksFetcherInitial());

  List<StocksModel> _allStocks = [];
  List<StocksModel> _watchedStocks = [];

  int _page = 1;
  int _perPage = 15;
  int _firstIndexSublist = 0;

  fetchStock(String collectionId) async {
    try {
      emit(StocksFetcherLoading());
      _allStocks = await _stocksEntity.getStockEntity();
      _watchedStocks = await _stocksWatchedEntity.getStockWatchedEntity(collectionId);
      _watchedStocks.forEach((e) {
        _allStocks.forEach((f) {
          if (e.figi == f.figi) {
            int index = _allStocks.indexWhere((e) => e.figi == f.figi);
            _allStocks.removeAt(index);
            _allStocks.insert(index, f.copyWith(isWatched: true, documentId: e.documentId));
          }
        });
      });
      if (_allStocks != null) {
        emit(StocksFetcherLoaded(
          listStocks: _allStocks.sublist(_firstIndexSublist, _perPage * _page),
          isLoadMore: false,
        ));
        _firstIndexSublist += _perPage;
        _page++;
      } else {
        emit(StocksFetcherFailure('gagal'));
      }
    } catch (e) {
      emit(StocksFetcherFailure('gagal*'));
    }
  }

  loadMoreStocks() async {
    await Future.delayed(Duration(seconds: 2));
    if (state is StocksFetcherLoaded) {
      StocksFetcherLoaded currentState = state as StocksFetcherLoaded;
      if ((_allStocks.length - _perPage * _page) >= _perPage) {
        emit(currentState.copyWith(
          listStock: currentState.listStocks + _allStocks.sublist(_firstIndexSublist, _perPage * _page),
          isLoadMore: true,
        ));
        _firstIndexSublist += _perPage;
        _page++;
      } else if ((_allStocks.length - _perPage * _page) < _perPage) {
        if ((_allStocks.length - _perPage * _page) >= 0) {
          emit(currentState.copyWith(
            listStock: currentState.listStocks + _allStocks.sublist(_firstIndexSublist),
            isLoadMore: true,
          ));
          _firstIndexSublist += _perPage;
          _page++;
        } else {
          emit(currentState.copyWith(
            listStock: currentState.listStocks,
            isLoadMore: false,
            hasReachMax: true,
          ));
        }
      }
    }
  }

  setWatched(String collectionId, StocksModel stocks) async {
    if (state is StocksFetcherLoaded) {
      StocksFetcherLoaded currentState = state as StocksFetcherLoaded;
      int index = currentState.listStocks.indexWhere((e) => e.figi == stocks.figi);
      currentState.listStocks[index] = stocks.copyWith(isWatched: !stocks.isWatched);

      if (!stocks.isWatched) {
        await _stocksWatchedEntity.addStockWatchedEntity(collectionId, stocks);
      } else {
        await _stocksWatchedEntity.deleteWatchedEntity(collectionId, stocks.documentId);
      }
      emit(currentState.copyWith(
        listStock: currentState.listStocks,
        isLoadMore: false,
        stock: stocks,
        hasReachMax: false,
      ));
    }
  }

  searchStocks(String val) async {
    if (state is StocksFetcherLoaded) {
      List<StocksModel> _filteredStocks = [];
      StocksFetcherLoaded currentState = state as StocksFetcherLoaded;
      _allStocks.forEach((e) {
        if (e.symbol.contains(val.toUpperCase()) || e.description.contains(val.toUpperCase())) {
          _filteredStocks.add(e);
        }
      });
      emit(currentState.copyWith(
        listStock: _filteredStocks,
      ));
    }
  }
}
