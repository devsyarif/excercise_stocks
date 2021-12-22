import 'package:excercise_stocks/feature/account/ui/account_page.dart';
import 'package:excercise_stocks/feature/authentication/cubit/authentication_cubit.dart';
import 'package:excercise_stocks/feature/authentication/ui/page/sign_in_page.dart';
import 'package:excercise_stocks/feature/stocks_search/cubit/stocks_fetcher_cubit.dart';
import 'package:excercise_stocks/feature/stocks_search/data/entity/stocks_search_entity.dart';
import 'package:excercise_stocks/feature/stocks_search/ui/page/stocks_search_page.dart';
import 'package:excercise_stocks/feature/stocks_watched/cubit/stocks_watched_fetcher_cubit.dart';
import 'package:excercise_stocks/feature/stocks_watched/data/entity/stocks_watched_entity.dart';
import 'package:excercise_stocks/feature/stocks_watched/ui/page/stocks_watched_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Stocks'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => BlocProvider.of<AuthenticationCubit>(context).logOut(),
            )
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.monetization_on_sharp)),
              Tab(icon: Icon(FontAwesomeIcons.binoculars)),
            ],
          ),
        ),
        body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            final _user = state is Authenticated ? state.user : null;
            return TabBarView(
              children: <Widget>[
                AccountPage(),
                BlocProvider(
                  create: (context) => StocksFetcherCubit(StocksSearchEntity(), StocksWatchedEntity())
                    ..fetchStock(
                      _user.email,
                    ),
                  child: StocksSearchPage(),
                ),
                BlocProvider(
                  create: (context) => StocksWatchedFetcherCubit(StocksWatchedEntity())
                    ..fetchWatchedStock(
                      _user.email,
                    ),
                  child: StocksWatchedPage(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
