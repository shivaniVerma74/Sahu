import 'dart:async';
import 'package:omega_employee_management/Screen/Auth_view/Login.dart';
import 'package:omega_employee_management/Provider/SettingProvider.dart';
import 'package:omega_employee_management/Screen/dashboard/Dashboard.dart';
import 'package:omega_employee_management/Screen/Intro_Slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/Color.dart';
import '../../Helper/String.dart';


class Splash extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



   String? userId;
   String? userName;
   getUserId() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId =  preferences.getString('userId');
    userName= preferences.getString('userName');
    print('userIddddddddddddd${userId}');
    print('userName----------${userName}');
}


  @override
  void initState() {
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    super.initState();
    //startTime();
 //  getUserId();
   checkingLogin();
  }

  String? uid;
   String? name,email;

  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('new_user_id');
      name = prefs.getString('user_name');
      email = prefs.getString('email');
      CUR_USERID = uid;
      print('-----USER____ID------${uid} and ${name} and ${email}');

    });
    if(uid == null || uid == ""){
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      });
    }else{
      Future.delayed(Duration(
          seconds: 3
      ), (){
        Navigator.pushReplacementNamed(context, "/home");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    //  SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      //key: _scaffoldKey,
      // bottomNavigationBar:Image.asset(
      //   'assets/images/splash.png',
      // ),
      body: Container(
              height:MediaQuery.of(context).size.height/1 ,
              width:MediaQuery.of(context).size.width/1,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [AppColors.primary,AppColors.secondary.withOpacity(1)],
        //       stops: [0, 1]),

        child: Image.asset('assets/images/splash.png',scale:4.3,),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration,navigationPage);
  }





  Future<void> navigationPage() async {
    SettingProvider settingsProvider =
        Provider.of<SettingProvider>(this.context, listen: false);

    bool isFirstTime = await settingsProvider.getPrefrenceBool(ISFIRSTTIME);

    if (isFirstTime) {

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Dashboard()));

    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroSlider(),
          )
      );
    }
  }




  setSnackbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.white,
      elevation: 1.0,
    ));
  }

  @override
  void dispose() {
    //  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
