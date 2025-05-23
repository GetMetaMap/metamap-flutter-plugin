---
title: "Flutter SDK"
excerpt: "MetaMap's Flutter SDK"
category: 61ae8e8dba577a0010791480
hidden: true
---

| LTS version (Recommended for most users): | Current Version(Latest features) |
|-------------------------------------------|----------------------------------|
| 4.4.8                                     | 4.4.8                            |



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
    MetaMapFlutter.showMetaMapFlow(clientId: "YOUR_CLIENT_ID",flowId: "YOUR_FLOW_ID", metaData: metaData);
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

Metadata is an additional optional parameter that can be used to replace certain settings:

### Set the Language:
By default the SDK language is set to "en" but it is editable to the language from the list:
"es", "fr", "pt", "ru", "tr", "de", "it", "pl", "th".
```bash
metaData: {"fixedLanguage": "value"}
```

### Set the Button Color:
By default main button color is white but it is editable by using hex Color format "hexColor".
```bash
metaData: {"buttonColor": "value"}
```

### Set the Title color of the button:
By default main button title color is black but it is editable by using hex Color format "hexColor".
```bash
metaData: {"buttonTextColor": "value"}
```

### Set identity Id as parameter for re-verification:
```bash
metaData: ["identityId": "value"]
   ```

### Set encryption Configuration Id as parameter for encrypting data.
```bash
metaData: ["encryptionConfigurationId": "value"]
   ```

### Set customization fonts as parameter.
to add custom fonts, the project needs to have these font files, otherwise SDK will use default fonts: 
```bash
metadata: ["regularFont": "REGULAR_FONT_NAME.ttf", "boldFont":  "BOLD_FONT_NAME.ttf"]
   ```


## Some error codes you may see during integration

`402` - MetaMap services are not paid: please contact your customer success manager

`403` - MetaMap credentials issues: please check your client id and MetaMap id
