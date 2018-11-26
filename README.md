# ColorDiffy
Colorize the differences between two String in the simpliest possible way!

Requires:

iOS 9.0+
Swift 4.0+

Usage:

Cocoapods:

1) Move to your project folder.
2) pod init
3) Open your Podfile and insert pod 'ColorDiffy'.
4) pod install

```swift
import ColorDiffy
ColorDiffy.findDifferencesBetween(stringOne: firstString, stringTwo: secondString)
ColorDiffy.findDifferencesBetween(stringOne: firstString, stringTwo: secondString ,color: UIColor)
```

![alt text](https://github.com/alex010x/ColorDiffy/blob/master/example.png)
