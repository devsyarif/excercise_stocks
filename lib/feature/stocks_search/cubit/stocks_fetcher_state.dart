part of 'stocks_fetcher_cubit.dart';

abstract class StocksFetcherState extends Equatable {
  const StocksFetcherState();

  @override
  List<Object> get props => [];
}

class StocksFetcherInitial extends StocksFetcherState {}

class StocksFetcherLoading extends StocksFetcherState {}

class StocksFetcherLoaded extends StocksFetcherState {
  final List<StocksModel> listStocks;
  final bool isLoadMore;
  final bool hasReachMax;
  final StocksModel stocks;

  const StocksFetcherLoaded({
    @required this.listStocks,
    this.isLoadMore,
    this.hasReachMax = false,
    this.stocks,
  });

  StocksFetcherLoaded copyWith({
    List<StocksModel> listStock,
    bool isLoadMore,
    bool hasReachMax,
    StocksModel stock,
  }) {
    return StocksFetcherLoaded(
      listStocks: listStock ?? this.listStocks,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      hasReachMax: hasReachMax ?? this.hasReachMax,
      stocks: stock ?? this.stocks,
    );
  }

  @override
  List<Object> get props => [this.listStocks, this.isLoadMore, this.stocks];
}

class StocksFetcherFailure extends StocksFetcherState {
  final String error;

  const StocksFetcherFailure(this.error);

  @override
  List<Object> get props => [this.error];
}
