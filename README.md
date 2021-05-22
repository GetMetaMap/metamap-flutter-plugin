# Mati Flutter plugin – BETA VERSION


## Installation

Let's start with setting up dependencies 

Please add `mati_plugin_flutter` dependency to your pubspec.yaml 
```
  mati_plugin_flutter: 1.0.1
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

In order to start Mati verification flow you should сonsecutively call those 2 methods 

```
  MatiFlutter.setParams(CLIENT_ID, FLOW_ID, METADATA)
```

```
  MatiFlutter.showMatiFlow()
```
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
