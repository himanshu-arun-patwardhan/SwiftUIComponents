//
//  UIScreen+Extensions.swift
//
//
//
//

import UIKit

public extension UIScreen {
    static var screenWidth: CGFloat { main.bounds.width }
    static var screenHeight: CGFloat { main.bounds.height }
    static var screenSize: CGSize { main.bounds.size }
    static var aspectRatio: CGFloat { main.bounds.width / main.bounds.height }
    static var isPortrait: Bool { main.bounds.height >= main.bounds.width }
    static var isLandscape: Bool { !isPortrait }
}
