//
//  Sha256.swift
//  ProyectoFinal_Ricardo_V1
//
//  Created by Morello Santos Ricardo on 11/15/19.
//  Copyright © 2019 Morello Santos Ricardo. All rights reserved.
//

import Foundation
import CommonCrypto
class Sha256{
    func sha256(str: String) -> String {
        
        if let strData = str.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_SHA256_DIGEST_LENGTH))
            _ = strData.withUnsafeBytes {
                CC_SHA256($0.baseAddress, UInt32(strData.count), &digest)
            }
            
            var sha256String = ""
            for byte in digest {
                sha256String += String(format:"%02x", UInt8(byte))
            }
            return sha256String
        }
        return ""
    }
}
