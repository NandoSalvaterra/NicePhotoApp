//
//  StringExtension.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 02/05/22.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
