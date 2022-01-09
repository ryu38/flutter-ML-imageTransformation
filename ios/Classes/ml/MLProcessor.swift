//
//  GANProcessor.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import Vision

protocol MLProcessor {
    
    func process(image: CIImage) throws -> UIImage
}
