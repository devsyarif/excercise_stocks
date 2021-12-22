import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:excercise_stocks/feature/stocks_search/ui/widget/item_stocks_widget.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ListStocksWidget extends StatelessWidget {
  final List<StocksModel> listStocks;
  final Function onEndOfPage;
  final Function(StocksModel) watchedTapped;

  const ListStocksWidget({
    @required this.listStocks,
    @required this.onEndOfPage,
    @required this.watchedTapped,
  });

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: onEndOfPage,
      child: Scrollbar(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(height: 1),
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ItemStocksWidget(
              stocks: listStocks[index],
              watchedTapped: watchedTapped,
            ),
          ),
          itemCount: listStocks.length,
        ),
      ),
    );
  }
}
