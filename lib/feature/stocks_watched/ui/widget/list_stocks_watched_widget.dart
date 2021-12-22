import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_watched/ui/widget/item_stocks_watched_widget.dart';
import 'package:flutter/material.dart';

class ListStocksWatchedWidget extends StatelessWidget {
  final List<StocksModel> listStocks;
  final Function(StocksModel) removeTapped;

  const ListStocksWatchedWidget({
    @required this.listStocks,
    @required this.removeTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ItemStocksWatchedWidget(
          stocks: listStocks[index],
          removeTapped: removeTapped,
        ),
      ),
      itemCount: listStocks.length,
    );
  }
}
