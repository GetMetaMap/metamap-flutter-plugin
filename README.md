# Mati Flutter plugin - beta

## Installation

Let's start with setting up dependencies 

Please add `mati_plugin_flutter` dependency to your pubspec.yaml 
```
  mati_plugin_flutter: 2.3.1
```

### Android

For android make sure that `minSdkVersion` inside YOUR_APP/build.gradle is at least `21`

### IOS

Make sure you got the following to info.plist

```
  <key>NSCameraUsageDescription</key>
  <string>Mati verification SDK requires camera use</string>

  <key>NSMicrophoneUsageDescription</key>
  <string>Mati verification SDK requires microphone use</string>

  <key>NSPhotoLibraryUsageDescription</key>
  <string>Mati verification SDK requires access to media library</string>
```

## Code

In order to start Mati verification flow you should call 

```
  MatiFlutter.showMatiFlow(CLIENT_ID, FLOW_ID, METADATA)
```
Inside button on pressed

And to listen for verificaiton result please wait for

```
  MatiFlutter.resultCompleter.future
```

with the code similar to the following

```
MatiFlutter.resultCompleter.future.then((result) => Fluttertoast.showToast(
      msg: result is ResultSuccess ? "Success ${result.verificationId}" : "Cancelled",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM));
```

Here  is demo example demo example

```
import 'package:flutter/material.dart';
import 'package:mati_plugin_flutter/mati_plugin_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mati flutter plugin demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void showMatiFlow() {
    MatiFlutter.showMatiFlow("CLIENT_ID", "FLOW_ID", {});
    MatiFlutter.resultCompleter.future.then((result) => Fluttertoast.showToast(
        msg: result is ResultSuccess ? "Success ${result.verificationId}" : "Cancelled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mati flutter plugin demo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showMatiFlow,
          child: const Text('Verify me'),
        )
      )
    );
  }
}
```

