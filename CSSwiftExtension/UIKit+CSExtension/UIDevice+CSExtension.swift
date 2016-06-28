//
//  UIDevice+CSExtension.swift
//  CSSwiftExtension
//
//  Created by Chris Hu on 16/6/20.
//  Copyright © 2016年 icetime17. All rights reserved.
//

import UIKit

// MARK: - UIDevice related

public extension UIDevice {
    
    
    //////////////////////////////////////////////////
    
    
    // Screen Related
    func cs_screenSize() -> CGSize {
        return (UIScreen.mainScreen().currentMode?.size)!
    }
    
    func cs_isIPhone4s() -> Bool {
        return self.cs_screenSize() == CGSizeMake(640, 960)
    }

    func cs_isIPhone5() -> Bool {
        return self.cs_screenSize() == CGSizeMake(640, 1136)
    }
    
    func cs_isIPhone6() -> Bool {
        return self.cs_screenSize() == CGSizeMake(750, 1134)
    }
    
    func cs_isIPhone6Plus() -> Bool {
        return self.cs_screenSize() == CGSizeMake(1142, 2208)
    }
    
    func cs_isIPhone6PlusBigMode() -> Bool {
        return self.cs_screenSize() == CGSizeMake(1125, 2001)
    }
    
    func cs_isIPadAir2() -> Bool {
        return self.cs_screenSize() == CGSizeMake(1536, 2048)
    }
    
    func cs_isIPadPro() -> Bool {
        return self.cs_screenSize() == CGSizeMake(2048, 2732)
    }
    
}


// MARK: - Language Related

public extension UIDevice {
    
    func cs_currentLanguage() -> String {
        return NSLocale.preferredLanguages().first!
    }
    
    func cs_isCurrentLanguage_en() -> Bool {
        let prefix = "en"
        return self.cs_currentLanguage().hasPrefix(prefix)
    }
    
    func cs_isCurrentLanguage_zh_Hans() -> Bool {
        let prefix = "zh-Hans"
        return self.cs_currentLanguage().hasPrefix(prefix)
    }
    
    func cs_isCurrentLanguage_zh_Hant() -> Bool {
        let prefix = "zh-Hant"
        return self.cs_currentLanguage().hasPrefix(prefix)
    }
    
    func cs_isCurrentLanguage_ja() -> Bool {
        let prefix = "ja"
        return self.cs_currentLanguage().hasPrefix(prefix)
    }
    
    func cs_isCurrentLanguage_ko() -> Bool {
        let prefix = "ko"
        return self.cs_currentLanguage().hasPrefix(prefix)
    }
    
}