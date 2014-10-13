Pkkup-iOS
=========

This is the iOS client for [Pkkup](http://pkkup.com)

## Download and Build Instructions

* Clone the repository
* Install [CocoaPods](http://cocoapods.org/)
  * `sudo gem install cocoapods`
* Install Pods
  * `pod install`
* Update/initialize the [hacktoolkit-ios_lib](https://github.com/hacktoolkit/hacktoolkit-ios_lib) submodule (temporary step until CocoaPods supports Swift source files natively)
  * `git submodule update --init` (subsequent update don't need the `--init` flag)
* Set up API keys
  * Create a `secrets.xcconfig` config file based on `secrets.xcconfig.template`
  * Obtain API keys from ... and add the keys to `secrets.xcconfig`
* Run it!

## Features

## Team

* [Jonathan Tsai](https://github.com/jontsai)
* [Deepak Chidambaram](https://github.com/grcdeepak1)
* [Chandaraprakash Kumar](https://github.com/chandaraprakash)

## License

* `Pkkup-iOS` is licensed under MIT. See `LICENSE`
* hacktoolkit-ios_lib` is licensed under MIT
  * Full details: <http://hacktoolkit.com>
* The Font Awesome font is licensed under the SIL OFL 1.1:
  * <http://scripts.sil.org/OFL>
* Font Awesome by Dave Gandy - <http://fontawesome.io>
  * Full details: <http://fontawesome.io/license>
