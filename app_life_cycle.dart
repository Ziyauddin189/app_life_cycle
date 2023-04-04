
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;
  int _counter = 0;
  Timer _timer = Timer.periodic(
    Duration(seconds: 1),
        (timer) {},
  );


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;

      if (_appLifecycleState == AppLifecycleState.paused) {
        print('App Lifecycle State: Paused');
        _timer.cancel();
      } else if (_appLifecycleState == AppLifecycleState.resumed) {
        print('App Lifecycle State: Resumed');
        startTimer();
      } else if (_appLifecycleState == AppLifecycleState.inactive) {
        print('App Lifecycle State: Inactive');
      } else if (_appLifecycleState == AppLifecycleState.detached) {
        print('App Lifecycle State: Detached');
      }
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          _counter++;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Lifecycle Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App Lifecycle Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 20),
              Text(
                'Counter: $_counter',
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
