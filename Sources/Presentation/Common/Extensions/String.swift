//
//  String.swift
//  CulinarApp
//
//  Created by Виталий Багаутдинов on 02.04.2026.
//

import Foundation

extension String
{
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
