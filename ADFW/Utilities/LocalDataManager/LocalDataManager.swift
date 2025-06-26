//
//  LoginDataManager.swift
//  EventApp
//
//  Created by MultiTV on 21/02/25.
//


import Foundation
import UIKit

class LocalDataManager {
    private static let userDefaultsKey = "loginResponseData"

    /// Save login response data  // change
    static func saveLoginResponse(_ response: User) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(response) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
  
    /// Retrieve login response data  // change
    static func getLoginResponse() -> User? {
        guard let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(User.self, from: savedData)
    }

    
//    static func updateUserProfileImage(_ imageUrl: String) {
//        guard var currentUser = getLoginResponse() else {
//            print("No saved user to update.")
//            return
//        }
//        
//        currentUser.upload_image = imageUrl
//        saveLoginResponse(currentUser)
//    }

    /// Clear saved login response data
    static func clearLoginResponse() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    
    static func saveId(userId: Int) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    static func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: "userId")
    }
    
    
    

}


struct APITokenManager {
    static var token: String? {
        get { UserDefaults.standard.string(forKey: "apiToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "apiToken") }
    }
}


struct ImageStorageManager {
    
    private static let directoryName = "Images"
    private static let imageKey = "savedProfileImage"

    static func saveImage(_ image: UIImage) -> Bool {
        guard let data = image.pngData() else { return false }

        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let folderURL = documentsURL.appendingPathComponent(directoryName)

        // Create folder if not exists
        if !fileManager.fileExists(atPath: folderURL.path) {
            try? fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
        }

        // Use a consistent filename or UUID
        let filename = UUID().uuidString + ".png"
        let fileURL = folderURL.appendingPathComponent(filename)

        do {
            try data.write(to: fileURL)
            UserDefaults.standard.set(fileURL.path, forKey: imageKey)
            return true
        } catch {
            print("❌ Failed to save image:", error)
            return false
        }
    }

    static func loadImage() -> UIImage? {
        guard let path = UserDefaults.standard.string(forKey: imageKey) else { return nil }
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }

    static func removeImage() {
        guard let path = UserDefaults.standard.string(forKey: imageKey) else { return }
        let fileURL = URL(fileURLWithPath: path)
        do {
            try FileManager.default.removeItem(at: fileURL)
            UserDefaults.standard.removeObject(forKey: imageKey)
        } catch {
            print("❌ Failed to remove image:", error)
        }
    }
}
