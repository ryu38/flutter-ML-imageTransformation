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
            if (mlProcessor == nil) {
                mlProcessor = try MLProcessorImpl(modelPath: modelPath)
            }
            let output = try mlProcessor!.process(image: input)
            try imageUtils.saveImage(image: output, path: outputPath)
            return nil
        } catch let error {
            return error.localizedDescription
        }
    }
}
