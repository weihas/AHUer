//
//  RSA+Func.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/10/5.
//

import Foundation
import SwiftyRSA

extension String{
    func rsaCrypto() -> String? {
        let key = """
-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBAI9fwyD3Hb5ryCjs7tR1n+SNkZgmUXxdMWl6g9L4s9xLsjsE0yjvaPeZRBIroo6Yc+laattX0WhTonMtAI/hP6/4G/ImBSsYUBilHL9BRQjXo7pfh02G93SycNxsOtLtatHJkSmDWjzj76RJypjpaBaMOIwMlU87pvaeX5d/gXorAgMBAAE=
-----END RSA PUBLIC KEY-----
"""
        do {
            let publicKey = try PublicKey(pemEncoded: key)
            let clear = try ClearMessage(string: self, using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1)
            return encrypted.base64String
        }catch{
            print("加密失败")
            return nil
        }
    }
}
