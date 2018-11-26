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

        var componentsNew: [Int: (str: String, range: NSRange)?] = [:]
        var componentsOld = [(str: String, range: NSRange)]()
        let mutableString = NSMutableAttributedString(string: stringTwo)
        var i = 0
        stringTwo.enumerateSubstrings(in: stringTwo.startIndex..<stringTwo.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsNew[i] = ((str: substring!, range: NSRange(substringRange, in: stringTwo)))
            i+=1
        }
        stringOne.enumerateSubstrings(in: stringOne.startIndex..<stringOne.endIndex, options: .byWords) { substring, substringRange, enclosingRange, stop in
            componentsOld.append((str: substring!, range: NSRange(substringRange, in: stringOne)))
        }

        for (key, substr) in componentsNew.sorted(by: { (arg0, arg1) -> Bool in
            arg0.key < arg1.key
        }) {
            guard !componentsOld.isEmpty else { break }
            for j in 0...key {
                guard j<componentsOld.count else { break }
                if substr?.str == componentsOld[j].str {
                    componentsOld.remove(at: j)
                    componentsNew.removeValue(forKey: key)
                    break
                }
            }
        }

        for (_,substr) in componentsNew {
            mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: substr!.range)
        }
        return mutableString
    }
}

