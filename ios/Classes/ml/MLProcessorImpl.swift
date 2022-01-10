//
//  MLProcessorImpl.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/08.
//

import Foundation
import CoreML
import Vision

class MLProcessorImpl: MLProcessor {
    
    let width: Int
    let height: Int
    
    private let _model: VNCoreMLModel
    private let _request: VNCoreMLRequest
    
    init(_ modelPath: String, _ width: Int, _ height: Int) throws {
        self.width = width
        self.height = height
        _model = try createVNModel(modelPath: modelPath)
        _request = VNCoreMLRequest(model: _model)
        _request.imageCropAndScaleOption = .centerCrop
        _request.usesCPUOnly = true
    }
    
    func process(image: CIImage) throws -> UIImage {
        let handler = VNImageRequestHandler(ciImage: image)
        try handler.perform([_request])
        if let result = _request.results?[0] as? VNPixelBufferObservation,
            let outputImage = UIImage(pixelBuffer: result.pixelBuffer) {
            return outputImage
        } else {
            throw AppError.nilResult("a mlprocess result is nil")
        }
    }
}

func createVNModel(modelPath: String) throws -> VNCoreMLModel {
    let modelUrl = URL.init(fileURLWithPath: modelPath)
    let compiledUrl = try MLModel.compileModel(at: modelUrl)
    let model = try MLModel(contentsOf: compiledUrl)
    return try VNCoreMLModel(for: model)
}
