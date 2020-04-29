import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:paymint/services/services.dart';
import 'package:paymint/pages/bitcoin/actions_view.dart';
import 'package:paymint/pages/bitcoin/activity_view.dart';

/// BitcoinView refers to the first tab in the app's [main_view] widget.
class BitcoinView extends StatefulWidget {
  BitcoinView({Key key}) : super(key: key);

  @override
  _BitcoinViewState createState() => _BitcoinViewState();
}

class _BitcoinViewState extends State<BitcoinView>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  PageStorageKey _scrollOffset = new PageStorageKey(0.0);

  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  double _fabDimension = 56.0;

  @override
  void initState() {
    this._tabController = TabController(vsync: this, length: 2, initialIndex: _scrollOffset.value.toInt());
    this._scrollController = ScrollController(keepScrollOffset: true, initialScrollOffset: _scrollOffset.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<BitcoinService>(context);
    return FutureBuilder(
      future: wallet.utxoData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return FutureBuilder(
          future: wallet.transactionData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return buildMainBitcoinView(context);
            } else {
              return Text('return loading state');
            }
          },
        );
      },
    );
  }

  // No need to pass future data as function parameters. Instead create provider reference object and pull directly
  // since this needs to wait for the future to finish before rendering anyway
  Scaffold buildMainBitcoinView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _OpenContainerWrapper(
        transitionType: _transitionType,
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Container(
            color: Colors.blue,
            height: this._fabDimension,
            width: this._fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      body: NestedScrollView(
        key: _scrollOffset,  // KEY HERE
        controller: _scrollController,
        headerSliverBuilder: (BuildContext _, bool boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.insert_chart),
                  onPressed: () {},
                )
              ],
              pinned: true,
              forceElevated: boxIsScrolled,
              expandedHeight: MediaQuery.of(context).size.width / 1.75,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("\$793.86", style: GoogleFonts.rubik()),
                centerTitle: true,
                titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Text(
                      '0.11372974 BTC',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                key: _scrollOffset,
                controller: _tabController,
                labelStyle: GoogleFonts.rubik(),
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.fromLTRB(60, 0, 60, 0),
                  borderSide: const BorderSide(width: 3.0, color: Colors.blue),
                ),
                tabs: <Widget>[
                  Tab(
                    text: 'Activity',
                  ),
                  Tab(
                    text: 'Security',
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          key: _scrollOffset,
          controller: _tabController,
          children: <Widget>[
            ActivityView(),
            Container(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
  });

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return ActionsView();
      },
      tappable: true,
      closedBuilder: closedBuilder,
    );
  }
}
