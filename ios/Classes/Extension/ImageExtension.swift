//
//  ImageExtension.swift
//  flutter_ml_image_transformation
//
//  Created by no145 on 2022/01/09.
//

import Foundation
import VideoToolbox

extension CIImage {
    
    func centerCropScale(width: Int, height: Int) -> CIImage {
        let width = CGFloat(width)
        let height = CGFloat(height)
        
        let srcWidth = self.extent.width
        let srcHeight = self.extent.height
        
        let srcAspect = srcHeight / srcWidth
        let cropAspect = height / width
        
        let resizedImage: CIImage
        if srcAspect > cropAspect {
            let cropHeight = srcWidth * cropAspect
            let croppedImage = self.cropped(to: CGRect(
                x: 0, y: ceil((srcHeight - cropHeight) / 2),
                width: srcWidth, height: cropHeight))
            resizedImage = croppedImage.transformed(by: CGAffineTransform(
                scaleX: width / srcWidth, y: height / cropHeight))
        } else {
            let cropWidth = srcHeight / cropAspect
            let croppedImage = self.cropped(to: CGRect(
                x: ceil((srcWidth - cropWidth) / 2), y: 0,
                width: cropWidth, height: srcHeight))
            resizedImage = croppedImage.transformed(by: CGAffineTransform(
                scaleX: width / cropWidth, y: height / srcHeight))
        }
        return resizedImage.cropped(to: CGRect(
            x: resizedImage.extent.minX, y: resizedImage.extent.minY,
            width: width, height: height))
    }
}

extension UIImage {
    /**
    Creates a new UIImage from a CVPixelBuffer.
    - Note: Not all CVPixelBuffer pixel formats support conversion into a
            CGImage-compatible pixel format.
    */
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        if let cgImage = CGImage.create(pixelBuffer: pixelBuffer) {
          self.init(cgImage: cgImage)
        } else {
          return nil
        }
    }
}

extension CGImage {
  /**
    Creates a new CGImage from a CVPixelBuffer.
    - Note: Not all CVPixelBuffer pixel formats support conversion into a
            CGImage-compatible pixel format.
  */
  public static func create(pixelBuffer: CVPixelBuffer) -> CGImage? {
    var cgImage: CGImage?
    VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
    return cgImage
  }
}
