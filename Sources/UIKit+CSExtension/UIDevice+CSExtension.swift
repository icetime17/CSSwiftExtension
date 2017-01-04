//
//  UIDevice+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/12/25.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

import UIKit


// MARK: - Language Related

public extension UIDevice {
    
    public var cs_currentLanguage: String {
        return Locale.preferredLanguages.first!
    }
    
    public var cs_isCurrentLanguage_en: Bool {
        let prefix = "en"
        return self.cs_currentLanguage.hasPrefix(prefix)
    }
    
    public var cs_isCurrentLanguage_zh_Hans: Bool {
        let prefix = "zh-Hans"
        return self.cs_currentLanguage.hasPrefix(prefix)
    }
    
    public var cs_isCurrentLanguage_zh_Hant: Bool {
        let prefix = "zh-Hant"
        return self.cs_currentLanguage.hasPrefix(prefix)
    }
    
    public var cs_isCurrentLanguage_ja: Bool {
        let prefix = "ja"
        return self.cs_currentLanguage.hasPrefix(prefix)
    }
    
    public var cs_isCurrentLanguage_ko: Bool {
        let prefix = "ko"
        return self.cs_currentLanguage.hasPrefix(prefix)
    }
    
}
