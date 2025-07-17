//
//  UploadResponseModel.swift
//  ADFW
//
//  Created by MultiTV on 10/07/25.
//

import Foundation

struct UploadResponse: Decodable {
    let status: Bool
    let message: String
    let data: String
}
