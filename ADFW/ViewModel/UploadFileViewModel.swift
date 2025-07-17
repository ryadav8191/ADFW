//
//  UploadFileViewModel.swift
//  ADFW
//
//  Created by MultiTV on 10/07/25.
//


import UIKit

class UploadFileViewModel {

    func uploadImageFile(
        image: UIImage,
        in view: UIView?,
        completion: @escaping (Result<UploadResponse, Error>) -> Void
    ) {
        NetworkManager.shared.uploadImage(
            urlString: APIEndpoints.uploadFile,
            parameters: [:], // no additional params required
            image: image,
            in: view,
            imageKey: "files",
            imageName: "uploaded_file.jpg", 
            completion: completion
        )
    }
}
