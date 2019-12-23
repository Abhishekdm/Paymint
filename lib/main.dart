import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:paymint/pages/pages.dart';

// main() is the entry point to the app. It initializes Hive (local database),
// runs the MyApp widget and checks for new users, caching the value in the
// miscellaneous box for later use
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDirec = await path.getApplicationDocumentsDirectory();
  Hive.init(appDirec.path);
  runApp(MyApp());

  final mscData = await Hive.openBox('miscellaneous');
  if ( mscData.isEmpty ) { mscData.put('first_launch', true); }
}

// MyApp initialises relevant services with MultiProvider
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Init walletstate here
        // ChangeNotifierProvider(
        //   builder: (_) => BitcoinService(),
        // )
      ],
      child: MaterialAppWithTheme(),
    );
  }
}

// Note: MaterialAppWithTheme and InitView are only separated for clarity. No other reason.

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paymint beta',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: InitView(),
    );
  }
}

class InitView extends StatefulWidget {
  const InitView({Key key}) : super(key: key);

  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  bool _isFirstLaunch;

  _checkFirstLaunch() async {
    final mscData = await Hive.openBox('miscellaneous');
    _isFirstLaunch = mscData.get('first_launch');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkFirstLaunch(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (this._isFirstLaunch) {
            return OnBoard();
          } else {
            return MainView(); 
          }
        } else {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text('Paymint'),
            ),
          );
        }
      },
    );
  }
}
