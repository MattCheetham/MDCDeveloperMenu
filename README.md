# MDCDeveloperMenu

MDCDeveloperMenu is an easy to install Framework designed to provide iOS developers with useful debug information about their application

Screenshots can be seen further down.

# Features

* Gesture activated menu
* Info plist viewer
* NSUserDefaults viewer & editor
* Levelled console logger 
* Device information viewer
* NSLog replacements with choice of warning levels
* Email logs/device information

# Requirements

* iOS 7
* CoreTelephony.framework
* SystemConfiguration.framework

# Installation
Drag and drop the files located in the MDCDeveloperMenu folder into your project and optionally create a folder for convenience. 

In your application delegate you will need to add the following lines to the top of your file

`#import "MDCDeveloperMenuViewController.h"`

Currently you will need to ensure that the developer menu is a property in your app delegate. You can do so by adding the following line of code

`@property (nonatomic, strong) MDCDeveloperMenuViewController *developerMenu;`

After you have set the rootViewController of your app in your didFinishLaunchingWithOptions: method, you will need to create and attach the the developer menu to the window. Implement the following code

```
self.developerMenu = [MDCDeveloperMenuViewController new];
[self.developerMenu attachToViewController:self.window.rootViewController];
```

# Usage

By default the menu is activated anywhere in the app with a four finger swipe up. To print logs into the device log console you will need to use one of the provided logging methods as a drop in replacement for NSLog;

```
MDCLogDebug
The lowest priority, and normally not logged except for messages from the kernel.

MDCLogInfo
The lowest priority that you would normally log, and purely informational in nature.

MDCLogNotice
Things of moderate interest to the user or administrator.

MDCLogWarning
Something is amiss and might fail if not corrected.

MDCLogErr
Something has failed.

MDCLogCrit
A failure in a key system.

MDCLogAlert
A serious failure in a key system.

MDCLogEmerg
The highest priority, usually reserved for catastrophic failures and reboot notices.
```

# Planned features

* Memory usage viewer

# Screenshots

![Main menu](http://f.cl.ly/items/1Z3e021v160C3i0B3v3O/photo%204.PNG)
![Log view](http://f.cl.ly/items/3c2g033R1x230P0V2T24/photo%201.PNG)
![Device Information View](http://f.cl.ly/items/0J3C0P1v0b1z2z2X3y2V/photo%203.PNG)