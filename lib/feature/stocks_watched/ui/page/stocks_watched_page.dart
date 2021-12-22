import 'package:excercise_stocks/common/empty_list_widget.dart';
import 'package:excercise_stocks/common/error_message_widget.dart';
import 'package:excercise_stocks/common/loader_widget.dart';
import 'package:excercise_stocks/feature/authentication/cubit/authentication_cubit.dart';
import 'package:excercise_stocks/feature/stocks_watched/cubit/stocks_watched_fetcher_cubit.dart';
import 'package:excercise_stocks/feature/stocks_watched/ui/widget/list_stocks_watched_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StocksWatchedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StocksWatchedFetcherCubit, StocksWatchedFetcherState>(
      builder: (context, state) {
        if (state is StocksWatchedFetcherLoading) {
          return LoaderWidget();
        } else if (state is StocksWatchedFetcherLoaded) {
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, authState) {
              final _user = authState is Authenticated ? authState.user : null;
              return state.listStocks.isNotEmpty
                  ? ListStocksWatchedWidget(
                      listStocks: state.listStocks,
                      removeTapped: (stocks) => BlocProvider.of<StocksWatchedFetcherCubit>(context).removeWatchedStocks(
                        _user.email,
                        stocks.documentId,
                      ),
                    )
                  : EmptyListWidget();
            },
          );
        } else if (state is StocksWatchedFetcherFailure) {
          return ErrorMessageWidget(state.error);
        } else {
          return Container();
        }
      },
    );
  }
}
