import 'package:flutter/material.dart';
import 'package:nyoba/pages/account/AccountScreen.dart';
import 'package:nyoba/provider/LoginProvider.dart';
import 'package:nyoba/services/Session.dart';
import 'package:nyoba/utils/utility.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '../../AppLocalizations.dart';
import '../auth/LoginScreen.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LobbyScreen.dart';
import '../category/CategoryScreen.dart';
import '../order/CartScreen.dart';
import '../blog/BlogScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool isLogin = false;
  Animation<double> animation;
  AnimationController controller;
  List<bool> isAnimate = [false, false, false, false, false];
  Timer _timer;

  static List<Widget> _widgetOptions = <Widget>[
    LobbyScreen(),
    BlogScreen(),
    CategoryScreen(
      isFromHome: true,
    ),
    CartScreen(
      isFromHome: true,
    ),
    AccountScreen()
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void comeToCategory() {
    setState(() {
      isAnimate[2] = true;
      _animatedFlutterLogoState(2);

      _onItemTapped(2);
    });
  }

  // @override
  // void setState(VoidCallback fn) {
  //   fn.call();
  //   super.setState(fn);
  // }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 24, end: 24).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          0.150,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              insetPadding: EdgeInsets.all(0),
              content: Builder(
                builder: (context) {
                  return Container(
                    height: 150.h,
                    width: 330.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('title_exit_alert'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsiveFont(14),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              AppLocalizations.of(context).translate('body_exit_alert'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: responsiveFont(12),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Container(
                            child: Column(
                          children: [
                            Container(
                              color: Colors.black12,
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pop(false),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15)),
                                          color: primaryColor),
                                      child: Text(
                                        AppLocalizations.of(context).translate('no'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pop(true),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15)),
                                          color: Colors.white),
                                      child: Text(
                                        AppLocalizations.of(context).translate('yes'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: primaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ))
                      ],
                    ),
                  );
                },
              )),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    return UpgradeAlert(
      canDismissDialog: false,
      showIgnore: false,
      messages: CustomMessages(),
      showReleaseNotes: false,
      child: WillPopScope(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: bottomNavBar,
                ),
              ],
            ),
          ),
          onWillPop: _onWillPop),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget bottomNavBar(BuildContext context, Widget child) {
    return Container(
      decoration:
          BoxDecoration(boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)]),
      child: BottomAppBar(
        child: Container(
          height: 50.h,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      isAnimate[0] = true;
                      _animatedFlutterLogoState(0);
                    });
                    await _onItemTapped(0);
                  },
                  child: Container(
                      child: navbarItem(
                          0,
                          "images/lobby/home.png",
                          "images/lobby/homeClicked.png",
                          AppLocalizations.of(context).translate('home'),
                          28,
                          14)),
                ),
              ),
              // Expanded(
              //     flex: 2,
              //     child: InkWell(
              //       onTap: () {
              //         setState(() {
              //           isAnimate[1] = true;
              //           _animatedFlutterLogoState(1);

              //           _onItemTapped(1);
              //         });
              //       },
              //       child: Container(
              //           child: navbarItem(
              //               1,
              //               "images/lobby/writing.png",
              //               "images/lobby/writingClicked.png",
              //               AppLocalizations.of(context).translate('blog'),
              //               28,
              //               14)),
              //     )),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      comeToCategory();
                    },
                    child: Container(
                        child: navbarItem(
                            2,
                            "images/lobby/category.png",
                            "images/lobby/categoryClicked.png",
                            AppLocalizations.of(context).translate('category'),
                            28,
                            14)),
                  )),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      if (Session.data.getBool('isLogin') != null) {
                        setState(() {
                          isLogin = Session.data.getBool('isLogin');
                        });
                      }

                      if (isLogin) {
                        setState(() {
                          isAnimate[3] = true;
                          _animatedFlutterLogoState(3);
                          _onItemTapped(3);
                        });
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.white,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Please login to use cart',
                                  style:
                                      TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    // if (Session.data.getBool('isLogin') != null) {
                                    //   setState(() {
                                    //     isLogin = Session.data.getBool('isLogin');
                                    //   });
                                    // }
                                    // if (!isLogin) {
                                    //   setState(() {
                                    //     _widgetOptions[4] = Login();
                                    //   });
                                    // } else {
                                    //   setState(() {
                                    //     _widgetOptions[4] = AccountScreen();
                                    //   });
                                    // }
                                    Navigator.pop(context);
                                    setState(() {
                                      isAnimate[4] = true;
                                      _animatedFlutterLogoState(4);
                                      _onItemTapped(4);
                                    });
                                  },

                                  // Navigator.push(
                                  //     context, MaterialPageRoute(builder: (_) => Login())),
                                  child: Text(
                                    'Go to Login  ➡',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                        child: navbarItem(
                            3,
                            "images/lobby/cart.png",
                            "images/lobby/cartClicked.png",
                            AppLocalizations.of(context).translate('cart'),
                            28,
                            14)),
                  )),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      if (Session.data.getBool('isLogin') != null) {
                        setState(() {
                          isLogin = Session.data.getBool('isLogin');
                        });
                      }
                      if (!isLogin) {
                        setState(() {
                          _widgetOptions[4] = Login();
                        });
                      } else {
                        setState(() {
                          _widgetOptions[4] = AccountScreen();
                        });
                      }
                      printLog(isLogin.toString(), name: 'isLogin');
                      printLog(Session.data.getBool('isLogin').toString(),
                          name: 'isLoginShared');
                      setState(() {
                        isAnimate[4] = true;
                        _animatedFlutterLogoState(4);

                        _onItemTapped(4);
                      });
                    },
                    child: Container(
                        child: navbarItem(
                            4,
                            "images/lobby/account.png",
                            "images/lobby/accountClicked.png",
                            AppLocalizations.of(context).translate('account'),
                            28,
                            14)),
                  ))
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        elevation: 5,
      ),
    );
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  _animatedFlutterLogoState(int index) {
    _timer = new Timer(const Duration(milliseconds: 200), () {
      setState(() {
        isAnimate[index] = false;
      });
    });
    return _timer;
  }

  Widget navbarItem(
    int index,
    String image,
    String clickedImage,
    String title,
    int width,
    int smallWidth,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 5,
        ),
        AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          opacity: isAnimate[index] == true ? 0 : 1,
          child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              alignment: Alignment.bottomCenter,
              width: isAnimate[index] == true ? smallWidth.w : width.w,
              height: isAnimate[index] == true ? smallWidth.w : width.w,
              child:
                  _selectedIndex == index ? Image.asset(clickedImage) : Image.asset(image)),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            title,
            style: TextStyle(
                fontWeight: _selectedIndex == index ? FontWeight.w600 : FontWeight.normal,
                fontSize: responsiveFont(8),
                fontFamily: 'Poppins',
                color: _selectedIndex == index ? primaryColor : Colors.black),
          ),
        ),
      ],
    );
  }
}

class CustomMessages extends UpgraderMessages {
  /// Override the message function to provide custom language localization.
  @override
  String message(UpgraderMessage messageKey) {
    switch (messageKey) {
      case UpgraderMessage.body:
        return 'App Name : {{appName}}\nYour Version : {{currentInstalledVersion}}\nAvailable : {{currentAppStoreVersion}}';
      case UpgraderMessage.buttonTitleIgnore:
        return 'Ignore';
      case UpgraderMessage.buttonTitleLater:
        return 'Later';
      case UpgraderMessage.buttonTitleUpdate:
        return 'Update Now';
      case UpgraderMessage.prompt:
        return 'Would you like to update it now?';
      case UpgraderMessage.title:
        return 'New Version Available';
    }
    // Messages that are not provided above can still use the default values.
    return super.message(messageKey);
  }
}
