//
//  PHAssetExtension.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Photos

extension PHAsset {

    func getUIImage() -> UIImage {
        let manager = PHImageManager.default
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager().requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
