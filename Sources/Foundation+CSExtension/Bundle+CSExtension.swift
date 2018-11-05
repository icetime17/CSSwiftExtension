//
//  Bundle+CSExtension.swift
//  CSSwiftExtension
//
//  Created by icetime17 on 2018/11/5.
//  Copyright © 2018 com.icetime17. All rights reserved.
//

import Foundation

extension Bundle {
    func jsonDataForFile(_ fileName: String?) -> Data? {
        guard let fileName = fileName else {
            return nil
        }
        guard let path = self.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let str = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        return str.data(using: String.Encoding.utf8)
    }
}
