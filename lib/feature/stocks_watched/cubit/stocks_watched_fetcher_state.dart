part of 'stocks_watched_fetcher_cubit.dart';

abstract class StocksWatchedFetcherState extends Equatable {
  const StocksWatchedFetcherState();

  @override
  List<Object> get props => [];
}

class StocksWatchedFetcherInitial extends StocksWatchedFetcherState {}

class StocksWatchedFetcherLoading extends StocksWatchedFetcherState {}

class StocksWatchedFetcherLoaded extends StocksWatchedFetcherState {
  final List<StocksModel> listStocks;

  StocksWatchedFetcherLoaded(this.listStocks);

  @override
  List<Object> get props => [this.listStocks];
}

class StocksWatchedFetcherFailure extends StocksWatchedFetcherState {
  final String error;

  const StocksWatchedFetcherFailure(this.error);

  @override
  List<Object> get props => [this.error];
}
