//
//  MLProcessorImpl.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import CoreML
import Vision

@available(iOS 11.0, *)
class MLProcessorImpl: MLProcessor {
    
    let _model: VNCoreMLModel
    private let _request: VNCoreMLRequest
    
    init(modelPath: String) throws {
        _model = try createVNModel(modelPath: modelPath)
        _request = VNCoreMLRequest(model: _model)
        _request.imageCropAndScaleOption = .centerCrop
        _request.usesCPUOnly = true
    }
    
    func process(image: CIImage) throws -> UIImage {
        let handler = VNImageRequestHandler(ciImage: image)
        try handler.perform([_request])
        if let result = request.result?[0] as? VNPixelBufferObservation {
            return UIImage(pixelBuffer: result.pixelBuffer)
        } else {
            throw AppError.nilResult("a mlprocess result is nil")
        }
    }
}

@available(iOS 11.0, *)
func createVNModel(modelPath: String) throws -> VNCoreMLModel {
    let modelUrl = URL.init(fileURLWithPath: modelPath)
    let compiledUrl = try MLModel.compileModel(at: modelUrl)
    let model = try MLModel(contentsOf: compiledUrl)
    return try VNCoreMLModel(for: model)
}
