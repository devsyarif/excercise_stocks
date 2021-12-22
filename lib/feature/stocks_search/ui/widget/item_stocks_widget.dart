import 'package:excercise_stocks/feature/stocks_search/data/model/stocks_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemStocksWidget extends StatelessWidget {
  final StocksModel stocks;
  final Function(StocksModel) watchedTapped;

  const ItemStocksWidget({
    @required this.stocks,
    @required this.watchedTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(stocks.symbol),
            SizedBox(height: 12),
            Text(
              stocks.description,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.binoculars,
            color: stocks.isWatched ? Colors.blue : Colors.grey[300],
          ),
          onPressed: () => watchedTapped(stocks),
        )
      ],
    );
  }
}
