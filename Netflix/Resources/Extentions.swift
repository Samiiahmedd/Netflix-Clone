//
//  Extentions.swift
//  Netflix
//
//  Created by Sami Ahmed on 30/10/2023.
//

import Foundation
extension String {
    func capatalizedFirstLetter () -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
