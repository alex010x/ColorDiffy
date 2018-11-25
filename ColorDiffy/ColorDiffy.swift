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
        var LCS = [(str: String, range: NSRange)]()
        let mutableString = NSMutableAttributedString(string: stringTwo)
        stringTwo.enumerateSubstrings(in: stringTwo.startIndex..<stringTwo.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsNew.append((str: substring!, range: NSRange(substringRange, in: stringTwo)))
        }
        stringOne.enumerateSubstrings(in: stringOne.startIndex..<stringOne.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsOld.append((str: substring!, range: NSRange(substringRange, in: stringOne)))
        }
        for (i, substr) in componentsNew.enumerated() {
            for (j, subOld) in componentsOld.enumerated() {
                if substr.str == subOld.str && i>=j {
                    if !LCS.contains(where: { (str,range) -> Bool in
                        str == substr.str && range == substr.range
                    }) {
                        LCS.append(substr)
                    }
                }
            }
        }

        for elem in componentsNew {
            if !LCS.contains(where: { (str, range) -> Bool in
                return elem.str == str && elem.range == range
            }) {
                rangesToConvert.append(elem.range)
            }
        }

        for range in rangesToConvert {
            mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return mutableString
    }
}

