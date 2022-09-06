---
title: "Flutter Changelog"
excerpt: "MetaMap's Flutter SDK Changelog"
slug: "flutter-changelog"
category: 61ae8e8dba577a0010791480
hidden: true
---

## Version
This plugin uses the latest versions of the MetaMap iOS and Android SDKs. For more information on the latest native SDK versions, go to:
* [Android](https://docs.getmati.com/docs/android-changelog)
* [iOS](https://docs.getati.com/docs/ios-changelog)

For changes to the plugin, go to the [changelog page](https://docs.getmati.com/docs/flutter-changelog)

# Install MetaMap for Flutter

   ## 1. Add `mati_plugin_flutter` dependency to your `pubspec.yaml` file:
   ```bash
   mati_plugin_flutter: 2.8.0
   ```

   ### Android

   For Android check that the `minSdkVersion` in `<YOUR_APP>/build.gradle` is &#8805;21

   ### iOS

   For iOS Minimum iOS version should be 12+

   Add the following to `info.plist`:

   ```xml
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

   ## 2. Implement MetaMap in Your App

  The following is an example application (MyApp) with the MetaMap verification flow:

  ```javascript
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
