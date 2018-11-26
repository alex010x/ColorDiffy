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

Example with 
```swift 
UILabel 
```

```swift
import ColorDiffy

let myLabel = UILabel()
```

```swift 
//if not specified, default color is red
myLabel.attributedText = ColorDiffy.findDifferencesBetween(stringOne: firstString, stringTwo: secondString)
```

OR

```swift
myLabel.attributedText = ColorDiffy.findDifferencesBetween(stringOne: firstString, stringTwo: secondString, color: UIColor.yellow)
```

![alt text](https://github.com/alex010x/ColorDiffy/blob/master/example.png)
