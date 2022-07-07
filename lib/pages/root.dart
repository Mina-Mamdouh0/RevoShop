import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:nyoba/pages/intro/SplashScreen.dart';
import 'package:nyoba/services/service.dart';
import 'package:provider/provider.dart';

import '../provider/HomeProvider.dart';
import 'intro/IntroScreen.dart';

class Root extends StatefulWidget {
  Root();

  @override
  State<StatefulWidget> createState() {
    return RootState();
  }
}

class RootState extends State<Root> {
  Widget rootWidget;
  // SplashScreen();

  @override
  void initState() {
    final home = Provider.of<HomeProvider>(context, listen: false);
    rootWidget = IntroScreen(intro: home.intro);
    super.initState();
    GetIt.instance.registerSingleton<Services>(Services(context));
  }

  @override
  Widget build(BuildContext context) {
    return rootWidget;
  }
}
