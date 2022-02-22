//
//  CMImageTransform.swift
//  flutter_ml_image_transformation
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import UIKit

class CMImageTransform {
    
    static let imageUtils: ImageUtils = ImageUtilsImpl()
    static var mlProcessor: MLProcessor?
    
    static func setModel(modelPath: String, width: Int, height: Int) -> String? {
        do {
            if (mlProcessor == nil) {
                mlProcessor = try MLProcessorImpl(modelPath, width, height)
            }
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
    
    static func transformImage(
        imagePath: String, outputPath: String) -> String? {
        do {
            guard let mlProcessor = self.mlProcessor else {
                throw AppError.nilResult("a model is not set")
            }
            let src = try imageUtils.loadImage(path: imagePath)
            let input = src.centerCropScale(
                width: mlProcessor.width, height: mlProcessor.height)
            let output = try mlProcessor.process(image: input)
            try imageUtils.saveImage(image: output, path: outputPath)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
}
