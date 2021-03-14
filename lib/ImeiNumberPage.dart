import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';


class ImeiNumberPage extends StatefulWidget {
  @override
  _ImeiNumberPageState createState() => _ImeiNumberPageState();
}

class _ImeiNumberPageState extends State<ImeiNumberPage> {
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
      await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);

    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformImei' ),
        ),
      ),
    );
  }
}
