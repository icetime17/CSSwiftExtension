//
//  UIDevice+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit


public extension CSSwift where Base: UIDevice {
    
}

// MARK: - SystemVersion Related

public extension CSSwift where Base: UIDevice {
    
    var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    func isSystemVersionEqualTo(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualTo(v)
    }
    
    func isSystemVersionHigherThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isHigherThan(v)
    }
    
    func isSystemVersionEqualToOrHigherThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualToOrHigherThan(v)
    }
    
    func isSystemVersionLowerThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isLowerThan(v)
    }
    
    func isSystemVersionEqualToOrLowerThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualToOrLowerThan(v)
    }
    
}

// MARK: - Language Related

public extension CSSwift where Base: UIDevice {
    
    var currentLanguage: String {
        return Locale.preferredLanguages.first!
    }
    
    var isCurrentLanguage_en: Bool {
        let prefix = "en"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    var isCurrentLanguage_zh_Hans: Bool {
        let prefix = "zh-Hans"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    var isCurrentLanguage_zh_Hant: Bool {
        let prefix = "zh-Hant"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    var isCurrentLanguage_ja: Bool {
        let prefix = "ja"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    var isCurrentLanguage_ko: Bool {
        let prefix = "ko"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
}
