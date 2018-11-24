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
    ///   - options: type of String Enumeration: can be .byWords, .bySentence, .byLines, etc. Default value is .byWords.
    ///   - color: the associated color to use to highlight the differences. Default color is red.
    ///   - returns: an NSMutableAttributedString object.

    public class func findDifferencesBetween(stringOne: String, stringTwo: String, options: String.EnumerationOptions = .byWords, color: UIColor = .red) -> NSMutableAttributedString {
        
        var rangesToConvert: [NSRange] = []
        var componentsNew = [(str: String, range: NSRange)]()
        var componentsOld = [(str: String, range: NSRange)]()
        let mutableString = NSMutableAttributedString(string: stringTwo)
        stringTwo.enumerateSubstrings(in: stringTwo.startIndex..<stringTwo.endIndex, options: options) { substring, substringRange, enclosingRange, stop in
            componentsNew.append((str: substring!, range: NSRange(substringRange, in: stringTwo)))
        }
        stringOne.enumerateSubstrings(in: stringOne.startIndex..<stringOne.endIndex, options: options) { substring, substringRange, enclosingRange, stop in
            componentsOld.append((str: substring!, range: NSRange(substringRange, in: stringOne)))
        }
        var s = 0
        for i in 0..<componentsOld.count {
            if i>=componentsNew.count { break }
            if s<i {
                s=i
            }
            while s<componentsNew.count && componentsNew[s].str != componentsOld[i].str {
                rangesToConvert.append(componentsNew[s].range)
                s+=1
            }
        }
        if componentsNew.count > componentsOld.count {
            for i in componentsOld.count..<componentsNew.count {
                rangesToConvert.append(componentsNew[i].range)
            }
        }
        for range in rangesToConvert {
            mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        return mutableString
    }
}

