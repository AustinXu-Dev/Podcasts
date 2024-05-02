//
//  String.swift
//  Podcast
//
//  Created by Austin Xu on 2024/5/2.
//

import Foundation

extension String{
    func toSecureHTTPS() -> String{
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
