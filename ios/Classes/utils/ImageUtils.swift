//
//  ImageUtils.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation

protocol ImageUtils {
    
    func loadImage(path: String) throws -> CIImage
    
    func saveImage(image: UIImage, path: String) throws
}
