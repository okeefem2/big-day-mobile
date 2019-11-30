import 'dart:async';

import 'package:flutter/material.dart';
import 'package:big_day_mobile/widgets/shared/app_drawer.dart';

import 'package:rxdart/rxdart.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String _days = '0';
  String _hours = '0';
  String _minutes = '0';
  String _seconds = '0';
  StreamSubscription _countDownTimer;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _countDownTimer = new Observable.periodic(
            new Duration(seconds: 1), (i) => new DateTime.utc(2019, 10, 19))
        .listen((countToDate) {
      var now = new DateTime.now();
      var difference = countToDate.difference(now);
      setState(() {
        _days = '${difference.inDays}';
        _hours = '${24 - now.hour}';
        _minutes = '${60 - now.minute}';
        _seconds = '${60 - now.second}';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _countDownTimer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  DecorationImage _buildBackgroungImage() {
    return DecorationImage(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.45), BlendMode.dstATop),
        fit: BoxFit.cover,
        image: AssetImage('assets/sun-mountain.png'));
  }

  Widget _buildLabelText(String text) {
    text = text != null ? text : '';
    return Text(text,
        style:
            TextStyle(color: Colors.black.withOpacity(0.65), fontSize: 16.0));
  }

  Widget _buildCountText(String text) {
    text = text != null ? text : '0';
    return Text(text,
        style:
            TextStyle(color: Colors.black.withOpacity(0.85), fontSize: 24.0));
  }

  Widget _buildCountRow() {
    return FadeTransition(
        opacity:
            CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildCountText(_days),
                _buildLabelText('Days')
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                _buildCountText(_hours),
                _buildLabelText('Hours')
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                _buildCountText(_minutes),
                _buildLabelText('Minutes')
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              children: <Widget>[
                _buildCountText(_seconds),
                _buildLabelText('Seconds')
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final width = deviceWidth > 600.0 ? 400.0 : deviceWidth;
    _animationController.forward();
    return Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(),
        body: Container(
            width: width,
            height: deviceHeight,
            decoration: BoxDecoration(image: _buildBackgroungImage()),
            padding: EdgeInsets.all(8.0),
            // child: Center(
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                  ],
                ),

                SizedBox(
                  height: 140.0,
                ),
                _buildCountRow(),
                // _buildLabelRow(),
              ],
            ))));
  }
}
