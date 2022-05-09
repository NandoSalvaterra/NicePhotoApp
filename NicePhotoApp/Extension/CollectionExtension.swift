//
//  CollectionExtension.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import Foundation

extension Collection where Element: Equatable {

    func element(after element: Element, wrapping: Bool = false) -> Element? {
        if let index = self.firstIndex(of: element) {
            let followingIndex = self.index(after: index)
            if followingIndex < self.endIndex {
                return self[followingIndex]
            } else if wrapping {
                return self[self.startIndex]
            }
        }
        return nil
    }
}
