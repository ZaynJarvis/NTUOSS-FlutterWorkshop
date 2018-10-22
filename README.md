# NTUOSS Flutter Workshop

##### made with ❤ by [Zayn Jarvis](https://github.com/ZaynJarvis) from [NTU Open Source Society](https://www.ntuoss.com)

*Leave a ⭐️ if you like this~*

![](img/FlutterBanner.png)

---

### Workshop Details

**When**: Friday, 26 Oct 2018. 6:30 PM - 8:30 PM.
**Where**: LT1, NTU North Spine Plaza
**Who**: NTU Open Source Society

**Questions**: We will be hosting a Pigeon Hole Live for collecting questions regarding the workshop.

Feedback & Error Reports: We will send out the link for collecting feedback as usual.
​	For further discussion or cooperation please contact @ [zaynjarvis@gmail.com](zaynjarvis@gmail.com).

***Disclaimer: This workshop is for educational purposes only. The redux framework is forked from [brianegan/flutter_architecture_samples](https://github.com/brianegan/flutter_architecture_samples). And information regarding Unity concepts are retrieved from [Flutter Document](https://flutter.io). No prototype or outcome of any type is intended for commercial use.***

---
### Prerequisites

1. **Flutter & Dart Compiled Code**

   Please download Flutter & Dart for development from [here](https://flutter.io/get-started/install/), and follow the instruction to complete the configuration for either iOS/Android development.

   For now, the latest release of Flutter is [Flutter Release Preview 2.](https://developers.googleblog.com/2018/09/flutter-release-preview-2-pixel-perfect.html).

   The next version of Flutter will finally be 1.0 🎉

   **Warning: We highly recommend you to download and config Flutter prior to coming to this workshop as it may take 30 - 60 minutes to complete the process. If you do not have Flutter correctly installed, you might only be able to attend an info-session of mobile app dev in Flutter rather than a hands-on session.**

2. **Visual Studio Code (or Xcode, Android Studio, IntelliJ for Dart Programming)**

    Use the recommended editor/IDE for Flutter development. Refer to [here](https://flutter.io/get-started/editor/).

3. **Complete Setup**
    
    Use `flutter doctor` in your terminal/cmd to check everything is correct with at least one editor/IDE is working.

---

### Agenda
* Introduction to Mobile App Development Framework: Flutter
    * Key Advantages:
        * Hot reload
        * Cross Platform
        * Compiled to Native Code
        * Support untyped and typed data declaration
    * Key differences:
        * No built-in UI designing Kit
        * Inline styles
        * Special Cupertino Style Component for iOS development.
* `Hello World App` of Flutter
    * Classes in Flutter
    * State Machine in Flutter
    * Data arguments in Classes
    * Class initialization shortcut
    * Add assets
    * Unit testing in Flutter
* `Currency App` build from scratch
    * HTTP request in Flutter
    * Local storage using SQFlite Database
    * Code Factorization and Redux
    * Change app icon and app name for deployment
* `TODO App` Redux framework in Flutter
    * Store
    * Actions
    * Dispatch
    * ViewModel
* `Speech Recognition App` Method Channel
    * Implement native APIs that Flutter does not support

---

### `Project 0`:
**Live Streaming of this workshop.**
[![NTUOSS-FlutterWorkshop](./img/NTUOSS-Logo.png)](https://www.youtube.com/watch?v=WHGb2NOMiQ0)

#### Flutter
* Key Advandatages:
    * Hot reload 
    * Cross Platform
    * Compiled to Native Code
    * Support untyped and typed data declaration 
    > `var`, `dynamic` vs `String`, `double`, `Map<String, double>`
    * build-in unit testing

* Key differences:
    * No built-in UI designing Kit
    * Inline styles
    > `Colors`, `Alignment`, `EdgeInsect`
    * Extended styles
    > `Icons`, `TextDecoration` and `AnimationController`
    * [Cupertino Style Component for iOS development](https://flutter.io/widgets/cupertino/)

---
### `Project 1`
* `Hello World App` of Flutter
    * Classes in Flutter
    * State Machine in Flutter
    * Arguments in Stateful Classes
    * Class initialization shortcut
    * Add assets
    * Unit testing in Flutter

With Flutter installed, Check everything is correct with 
```bash
flutter doctor
``` 
You should get a similar output like this (Making one of the editor work is enough)
```bash
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel beta, v0.9.4, on Mac OS X 10.14 18A391, locale en-SG)
[✓] Android toolchain - develop for Android devices (Android SDK 28.0.1)
[✓] iOS toolchain - develop for iOS devices (Xcode 10.0)
[✓] Android Studio (version 3.1)
[✓] IntelliJ IDEA Community Edition (version 2018.2)
[✓] VS Code (version 1.28.2)
[✓] Connected devices (1 available)

• No issues found!
```
> If you do not have connected devices error, connect your phone to computer (For iOS developer make sure your device has trusted your computer to install app on in. Read [here](https://flutter.io/setup-macos/#platform-setup).)

> You can connect a simulator(Xcode) or an emulator(Android Studio) for development as well.

Then we can get started by running
```bash
flutter create myapp
```
This command will create a flutter project folder for you named `myapp`

Then we can change directory into our project folder and start to run the project
```bash
cd myapp
flutter run
```
Now you should have a counter app running in your device.

---
### `Project 2`
* `Currency App` build from scratch
    * HTTP request in Flutter
    * Local storage using SQFlite Database
    * Code Factorization and Redux
    * Change app icon and app name for deployment
    