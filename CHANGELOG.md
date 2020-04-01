## 2.0.4

* Android: Depend on GMS base instead of location;
* Android: Make a clear separation between Application lifecycle and methodchannel implementation;
* Android: Added end-to-end tests.

## 2.0.3+hotfix.1

* Android: Fix a possible null reference when the plugin is called from an App running in the background.

## 2.0.3

* Android: Migrate to FlutterPlugin Android API (better support for Add-to-App);

## 2.0.2

* Migrate to AndroidX
* Synchonize Gradle and Gradle Wrapper versions with Flutter stable (1.12.13+hotfix.5)

## 2.0.1

* No longer rely on the Activity object when this plugin is instantiated.

## 2.0.0
* Move from swift to Objective-C and from Kotlin to Java

## 1.0.6+1 
* Revert the breaking 1.0.6 update. 1.0.6 was known to be breaking and should have incremented the major version number instead of the minor. This revert is in and of itself breaking for anyone that has already migrated however. Anyone who has already migrated their app to AndroidX should immediately update to 2.0.0 instead. That's the correctly versioned new push of 1.0.6.

## 1.0.6 
* **BAD.** This was a breaking change that was incorrectly published on a minor version upgrade, should never have happened. Reverted by 1.0.6+1.

"**Breaking change.** Migrate from the deprecated original Android Support Library to AndroidX. This shouldn't result in any functional changes, but it requires any Android apps using this plugin to also migrate if they're using the original support library."

## 1.0.5
* **BAD.** This was a breaking change that was incorrectly published on a minor version upgrade, should never have happened. Reverted by 1.0.6+1.

"**Breaking change.** Migrate from the deprecated original Android Support Library to AndroidX. This shouldn't result in any functional changes, but it requires any Android apps using this plugin to also migrate if they're using the original support library."

## 1.0.4

* Update used Kotlin and Gradle versions.

## 1.0.3

* Bug fix that is introduced due to breaking changes in Flutter version 0.9.6.

## 1.0.2

* Add additional iOS configuration to make sure it compiles correcty using Swift 4.1

## 1.0.1

* Add iOS implementation that returns false


## 1.0.0

* Initial release
