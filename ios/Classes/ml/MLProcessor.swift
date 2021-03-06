//
//  GANProcessor.swift
//  flutter_ml_image_transformation
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import Vision

protocol MLProcessor {
    
    var width: Int { get }
    var height: Int { get }
    
    func process(image: CIImage) throws -> UIImage
}
