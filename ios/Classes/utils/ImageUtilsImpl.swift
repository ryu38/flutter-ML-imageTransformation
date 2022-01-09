//
//  ImageUtilsImpl.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation

class ImageUtilsImpl: ImageUtils {
    
    func loadImage(path: String) throws -> CIImage {
        let url = URL.init(fileURLWithPath: path)
        let imageData = try Data(contentsOf: url)
        guard let image = CIImage(data: imageData) else {
            throw AppError.nilResult("loadImage: UIImage")
        }
        return image
    }
    
    func saveImage(image: UIImage, path: String) throws {
        guard let jpgData = image.jpegData(compressionQuality: 1.0) else {
            throw AppError.nilResult("fail to convert uiimage to jpg")
        }
        let url = URL.init(fileURLWithPath: path)
        try jpgData.write(to: url)
    }
}
