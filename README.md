# Mati Flutter plugin – BETA VERSION


## Installation

Let's start with setting up dependencies 

```
mati_plugin_flutter: CURRENT_VERSION_OF_MATI_PLUGIN_FLUTTER
```

And in oreder to use sdk for iOS please add those dependencies to your Podfile

```
  pod 'Mati-Global-ID-SDK'
  pod 'Socket.IO-Client-Swift', '~> 15.2.0'
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
