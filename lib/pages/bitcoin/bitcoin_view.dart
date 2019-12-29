import './actions_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// lazy import
import './activity_view.dart';

class BitcoinView extends StatefulWidget {
  BitcoinView({Key key}) : super(key: key);

  @override
  _BitcoinViewState createState() => _BitcoinViewState();
}

class _BitcoinViewState extends State<BitcoinView>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    this._tabController = TabController(vsync: this, length: 2);
    this._scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
  }

  @override
  void dispose() {
    this._tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/actions');
        },
        child: Icon(Icons.add),
      ),
      body: NestedScrollView(
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
                title: Text(
                  "\$793.86",
                  style: GoogleFonts.rubik(),
                ),
                centerTitle: true,
                titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                collapseMode: CollapseMode.pin,
                background: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Text(
                      '0.11372974 BTC',
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
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
        body: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ActivityView(),
              Container(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Route _pushActionsRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => ActionsView(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       return child;
  //     },
  //   );
  // }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutQuart);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  Container _buildFabTiles() {
    return Container(height: 150, child: Text('This is cool'));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: _buildFabTiles(),
            ),
          ),
        ),
      ),
    );
  }
}
