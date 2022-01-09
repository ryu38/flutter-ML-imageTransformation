//
//  AppError.swift
//  flutter_pytorch_coreml_cyclegan
//
//  Created by no145 on 2022/01/09.
//

import Foundation

enum AppError: LocalizedError, Error {
    case nilResult(String)
    
    var errorDescription: String? {
        switch self {
        case .nilResult(let message): return message
        }
    }
}
