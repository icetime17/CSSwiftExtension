//
//  UIDevice+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit


public extension CSSwift where Base: UIDevice {

    public static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #endif
        
        return false
    }
    
}

// MARK: - SystemVersion Related

public extension CSSwift where Base: UIDevice {
    
    public var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    public func isSystemVersionEqualTo(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualTo(v)
    }
    
    public func isSystemVersionHigherThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isHigherThan(v)
    }
    
    public func isSystemVersionEqualToOrHigherThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualToOrHigherThan(v)
    }
    
    public func isSystemVersionLowerThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isLowerThan(v)
    }
    
    public func isSystemVersionEqualToOrLowerThan(_ v: String) -> Bool {
        return base.systemVersion.cs_isEqualToOrLowerThan(v)
    }
    
}

// MARK: - Language Related

public extension CSSwift where Base: UIDevice {
    
    public var currentLanguage: String {
        return Locale.preferredLanguages.first!
    }
    
    public var isCurrentLanguage_en: Bool {
        let prefix = "en"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    public var isCurrentLanguage_zh_Hans: Bool {
        let prefix = "zh-Hans"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    public var isCurrentLanguage_zh_Hant: Bool {
        let prefix = "zh-Hant"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    public var isCurrentLanguage_ja: Bool {
        let prefix = "ja"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
    public var isCurrentLanguage_ko: Bool {
        let prefix = "ko"
        return self.currentLanguage.hasPrefix(prefix)
    }
    
}
