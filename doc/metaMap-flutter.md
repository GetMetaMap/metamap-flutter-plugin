---
title: "Flutter Changelog"
excerpt: "MetaMap's Flutter SDK Changelog"
slug: "flutter-changelog"
category: 61ae8e8dba577a0010791480
hidden: true
---

| LTS version (Recommended for most users): | Current Version(Latest features) |
|-------------------------------------------|----------------------------------|
| 4.0.3                                     | 4.0.3                            |



## Install MetaMap for Flutter

Add `metamap_plugin_flutter` dependency to your `pubspec.yaml` file where `<version_number>` is either the LTS or the latest version of the plugin:
```bash
  metamap_plugin_flutter: ^<version_number>
```

### Android

For Android, check that the `minSdkVersion` in `<YOUR_APP>/build.gradle` is &#8805;21

### iOS

MetaMap's Flutter plugin requires iOS version &gt;12

Add the following to `info.plist`:

```bash
  <key>NSCameraUsageDescription</key>
  <string>MetaMap verification SDK requires camera use</string>

  <key>NSMicrophoneUsageDescription</key>
  <string>MetaMap verification SDK requires microphone use</string>

  <key>NSPhotoLibraryUsageDescription</key>
  <string>MetaMap verification SDK requires access to media library</string>

  <key>NSLocationWhenInUseUsageDescription</key>
  <string>MetaMap will use your location information to provide best possible verification experience.</string>

  <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  <string>MetaMap will use your location information to provide best possible verification experience.</string>

  <key>NSLocationAlwaysUsageDescription</key>
  <string>MetaMap will use your location information to provide best possible verification experience.</string>
```

## Implement MetaMap in Your App

   The following is an example application (MyApp) with the MetaMap verification flow:

```bash
import 'package:flutter/material.dart';
import 'package:metamap_plugin_flutter/metamap_plugin_flutter.dart';
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
    final metaData = {"key": "value"};
    MetaMapFlutter.showMetaMapFlow("CLIENT_ID", "FLOW_ID", metaData);
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

## Metadata Usage

Metadata is an additional optional parameters:

Set the Language:
```bash
metaData: {"fixedLanguage": "es"}
```

Set the Button Color:
```bash
yourMetadata: {"buttonColor": "hexColor"}
```

Set the Title color of the button:
```bash
yourMetadata: {"buttonTextColor": "hexColor"}
```

Set identity Id as parameter for re-verification:
```bash
yourMetadata: ["identityId": "value"]
   ```

## Some error codes you may see during integration

`402` - MetaMap services are not paid: please contact your customer success manager

`403` - MetaMap credentials issues: please check your client id and MetaMap id
