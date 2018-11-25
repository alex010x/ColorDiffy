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
        var evaluatedIndexes: [Int] = []
        let mutableString = NSMutableAttributedString(string: stringTwo)
        stringTwo.enumerateSubstrings(in: stringTwo.startIndex..<stringTwo.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsNew.append((str: substring!, range: NSRange(substringRange, in: stringTwo)))
        }
        stringOne.enumerateSubstrings(in: stringOne.startIndex..<stringOne.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsOld.append((str: substring!, range: NSRange(substringRange, in: stringOne)))
        }
        var lastOld = 0
        for (i, substr) in componentsNew.enumerated() {
            for (j, subOld) in componentsOld.enumerated() {
                if j<lastOld { continue }
                evaluatedIndexes.append(i)
                if substr.str != subOld.str || i<j {
                    if j+1 < componentsOld.count && substr.str == componentsOld[j+1].str {
                        lastOld+=1
                    } else {
                        rangesToConvert.append(substr.range)
                    }
                    break
                } else {
                    lastOld+=1
                    break
                }
            }
        }
        if var max = evaluatedIndexes.max() {
            max += 1
            if max < componentsNew.count {
                for i in max..<componentsNew.count {
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

