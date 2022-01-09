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
    
//    func centerResize(image: CIImage) -> CIImage {
//        <#code#>
//    }

//    func saveImage(image: UIImage, path: String) throws {
//        <#code#>
//    }
}
