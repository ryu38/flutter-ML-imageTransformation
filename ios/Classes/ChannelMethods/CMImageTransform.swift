//
//  CMImageTransform.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import UIKit

class CMImageTransform {
    
    static let imageUtils: ImageUtils = ImageUtilsImpl()
    static var mlProcessor: MLProcessor?
    
    static func main(imagePath: String, modelPath: String, outputPath: String) -> String? {
        do {
            let src = try imageUtils.loadImage(path: imagePath)
            let input = src.centerCropScale(width: 256, height: 256)
            guard (mlProcessor != nil) else {
                
            }
            guard let jpgData = UIImage(ciImage: input).jpegData(compressionQuality: 1.0) else {
                throw AppError.nilResult("nil in converting jpg")
            }
            let outputUrl = URL.init(fileURLWithPath: outputPath)
            try jpgData.write(to: outputUrl)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
}
