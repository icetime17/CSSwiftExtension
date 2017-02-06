//
//  UIDevice+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit


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
