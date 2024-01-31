//
//  UIFonts+Extension.swift
//  EyeHub
//
//  Created by Nattapon Suwanno on 28/1/2567 BE.
//

import UIKit.UIFont
typealias Font = UIFont

// MARK: - FontFamily
enum FontFamily {
    enum Kanit {
        // MARK: - Italic
        static let medium = FontConvertible(
            name: "Kanit-Medium",
            family: "Kanit",
            path: "Kanit-Medium.ttf"
        )
        
        static let light = FontConvertible(
            name: "Kanit-Light",
            family: "Kanit",
            path: "Kanit-Light.ttf"
        )
        
        static let all: [FontConvertible] = [
            medium
        ]
    }
    static let allCustomFonts: [FontConvertible] = [Kanit.all].flatMap { $0 }
    static func registerAllCustomFonts() {
        allCustomFonts.forEach { $0.register() }
    }
}

struct FontConvertible {
    let name: String
    let family: String
    let path: String

    func font(size: CGFloat) -> Font {
        return Font(font: self, size: size)
    }

    func register() {
        guard let url = url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }

    fileprivate var url: URL? {
        let bundle = BundleToken.bundle
        return bundle.url(forResource: path, withExtension: nil)
    }
}

extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}


