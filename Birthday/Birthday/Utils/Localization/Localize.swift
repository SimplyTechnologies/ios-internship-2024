//
//  Localize.swift
//  Birthday
//
//  Created by Narek on 21.10.24.
//

import Foundation
/// Internal current language key
let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"

/// Default language. English. If English is unavailable defaults to base localization.
let LCLDefaultLanguage = "en"

/// Base bundle as fallback.
let LCLBaseBundle = "Base"

// Name for language change notification
let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"

// MARK: Localization Syntax

func localized(_ string: String) -> String {
    return string.localized
}

func localized(_ string: String, arguments: CVarArg...) -> String {
    return String(format: string.localized, arguments: arguments)
}

func localizedPlural(_ string: String, argument: CVarArg) -> String {
    return string.localizedPlural(argument)
}

extension String {
    var localized: String {
        return localized(using: nil, in: .main)
    }

    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }

    func localizedPlural(_ argument: CVarArg) -> String {
        return NSString.localizedStringWithFormat(localized as NSString, argument) as String
    }

    func commented(_ argument: String) -> String {
        return self
    }

    func localized(using tableName: String?, in bundle: Bundle?) -> String {
        let bundle: Bundle = bundle ?? .main
        if let path = bundle.path(forResource: Localize.currentLanguage(), ofType: "lproj"),
           let bundle = Bundle(path: path)
        {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        } else if let path = bundle.path(forResource: LCLBaseBundle, ofType: "lproj"),
                  let bundle = Bundle(path: path)
        {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }

    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized(using: tableName, in: bundle), arguments: arguments)
    }

    func localizedPlural(argument: CVarArg, using tableName: String?, in bundle: Bundle?) -> String {
        return NSString.localizedStringWithFormat(
            localized(using: tableName, in: bundle) as NSString, argument) as String
    }
}

class Localize: NSObject {
    class func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.firstIndex(of: "Base"), excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }

    class func currentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return defaultLanguage()
    }

    class func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage() {
            UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
        }
    }

    class func defaultLanguage() -> String {
        var defaultLanguage = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }

    class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(defaultLanguage())
    }

    class func displayNameForLanguage(_ language: String) -> String {
        let locale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}
