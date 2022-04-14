
## Install MetaMap for Flutter

1. Add `mati_plugin_flutter` dependency to your `pubspec.yaml` file:
```bash
  mati_plugin_flutter: any
```

### Android

For Android check that the `minSdkVersion` in `<YOUR_APP>/build.gradle` is &#8805;21

### iOS

For iOS Minimum iOS version should be 12+

Add the following to `info.plist`:

```bash
  <key>NSCameraUsageDescription</key>
  <string>MetaMap verification SDK requires camera use</string>

  <key>NSMicrophoneUsageDescription</key>
  <string>MetaMap verification SDK requires microphone use</string>

  <key>NSPhotoLibraryUsageDescription</key>
  <string>MetaMap verification SDK requires access to media library</string>
```

## Implement MetaMap in Your App

2. The following is an example application (MyApp) with the MetaMap verification flow:
   The following is an example application (MyApp) with the MetaMap verification flow:

```bash
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
      title: 'MetaMap flutter plugin demo',
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

  void showMetaMapFlow() {
    MetaMapFlutter.showMetaMapFlow("CLIENT_ID", "FLOW_ID", {});
    MetaMapFlutter.resultCompleter.future.then((result) => Fluttertoast.showToast(
        msg: result is ResultSuccess ? "Success ${result.verificationId}" : "Cancelled",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MetaMap flutter plugin demo"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showMetaMapFlow,
          child: const Text('Verify me'),
        )
      )
    );
  }
}
```
