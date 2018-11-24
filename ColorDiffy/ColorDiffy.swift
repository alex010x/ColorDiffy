//
//  ColorDiffy.swift
//  ColorDiffy
//
//  Created by Alessandro Minopoli on 23/11/2018.
//  Copyright © 2018 Alessandro Minopoli. All rights reserved.
//

public class ColorDiffy {

    /// Colorize the differences between two Strings.
    ///
    /// - parameters:
    ///   - stringOne: the first String to be compared.
    ///   - stringTwo: the second String to be compared. This will be the colorized String.
    ///   - color: the associated color to use to highlight the differences. Default color is red.
    ///   - returns: an NSMutableAttributedString object.

    public class func findDifferencesBetween(stringOne: String, stringTwo: String, color: UIColor = .red) -> NSMutableAttributedString {

        var rangesToConvert: [NSRange] = []
        var componentsNew = [(str: String, range: NSRange)]()
        var componentsOld = [(str: String, range: NSRange)]()
        var evaluatedIndexes = Set<Int>()
        let mutableString = NSMutableAttributedString(string: stringTwo)
        stringTwo.enumerateSubstrings(in: stringTwo.startIndex..<stringTwo.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsNew.append((str: substring!, range: NSRange(substringRange, in: stringTwo)))
        }
        stringOne.enumerateSubstrings(in: stringOne.startIndex..<stringOne.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsOld.append((str: substring!, range: NSRange(substringRange, in: stringOne)))
        }
        var s = 0
        var invalidJump: Bool = false
        for i in 0..<componentsOld.count {
            invalidJump = false
            if i>=componentsNew.count { break }
            while s<componentsNew.count && componentsNew[s].str != componentsOld[i].str {
                rangesToConvert.append(componentsNew[s].range)
                evaluatedIndexes.insert(s)
                s+=1
                if i+1 < componentsOld.count && s < componentsNew.count {
                    if componentsNew[s].str == componentsOld[i+1].str {
                        invalidJump = true
                        break
                    }
                }
            }
            if !invalidJump {
                evaluatedIndexes.insert(s)
                s+=1
            }
        }
        if componentsNew.count > componentsOld.count {
            for i in componentsOld.count..<componentsNew.count {
                if !evaluatedIndexes.contains(i) {
                    rangesToConvert.append(componentsNew[i].range)
                }
            }
        }
        for range in rangesToConvert {
            mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return mutableString
    }
}


