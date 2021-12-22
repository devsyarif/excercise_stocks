import 'package:excercise_stocks/common/custom_snackbar.dart';
import 'package:excercise_stocks/common/empty_list_widget.dart';
import 'package:excercise_stocks/common/error_message_widget.dart';
import 'package:excercise_stocks/common/loader_widget.dart';
import 'package:excercise_stocks/feature/authentication/cubit/authentication_cubit.dart';
import 'package:excercise_stocks/feature/stocks_search/cubit/stocks_fetcher_cubit.dart';
import 'package:excercise_stocks/feature/stocks_search/ui/widget/list_stocks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StocksFetcherCubit, StocksFetcherState>(
      listener: (context, state) {
        if (state is StocksFetcherLoaded) {
          if (state.hasReachMax) {
            CustomSnackBar.snackbar(context, 'Mencapai maksimum');
          }
        }
      },
      builder: (context, state) {
        if (state is StocksFetcherLoading) {
          return LoaderWidget();
        } else if (state is StocksFetcherLoaded) {
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, authState) {
              final _user = authState is Authenticated ? authState.user : null;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari stocks disini',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      onChanged: (val) {
                        val.isEmpty
                            ? BlocProvider.of<StocksFetcherCubit>(context).fetchStock(_user.email)
                            : BlocProvider.of<StocksFetcherCubit>(context).searchStocks(val);
                      },
                    ),
                  ),
                  Expanded(
                    child: state.listStocks.isNotEmpty
                        ? ListStocksWidget(
                            listStocks: state.listStocks,
                            onEndOfPage: BlocProvider.of<StocksFetcherCubit>(context).loadMoreStocks,
                            watchedTapped: (stocks) => BlocProvider.of<StocksFetcherCubit>(context).setWatched(
                              _user.email,
                              stocks,
                            ),
                          )
                        : EmptyListWidget(),
                  ),
                ],
              );
            },
          );
        } else if (state is StocksFetcherFailure) {
          return ErrorMessageWidget(state.error);
        } else {
          return Container();
        }
      },
    );
  }
}
