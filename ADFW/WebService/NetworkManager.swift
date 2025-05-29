import Foundation
import UIKit

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case unsuccessful
    case decodingError(Error)
    case httpError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .unsuccessful:
            return "The request was unsuccessful."
        case .noData:
            return "No data was received from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .httpError(let statusCode):
            return "Server returned an error (HTTP \(statusCode))."
        }
    }
}


class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    // MARK: - Fetch Data (GET Request)
    func fetchData<T: Decodable>(from urlString: String, in view: UIView? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        DispatchQueue.main.async { [weak self] in
            if let view = view {
                Loader.shared.show(in: view)
            }
        }

        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                if view != nil {
                    Loader.shared.hide()
                }
            }
            completion(.failure(NetworkError.invalidURL))
            return
        }

        print("📡 Request URL: \(urlString)")

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                if view != nil {
                    Loader.shared.hide()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if let _ = view {
                    Loader.shared.hide()
                }
            })


            if let httpResponse = response as? HTTPURLResponse {
                print("🔄 Response Status Code: \(httpResponse.statusCode)")
            }

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Response Data: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }

    // MARK: - Send Request (POST)
    func sendRequest<T: Decodable>(_ request: URLRequest, in view: UIView? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async { [weak self] in
            if let view = view {
                Loader.shared.show(in: view)
            }
        }

        print("📡 Request: \(request.url?.absoluteString ?? "No URL")")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("📤 Request Body: \(bodyString)")
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                if let _ = view {
                    Loader.shared.hide()
                }
            }
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                if let _ = view {
//                    Loader.shared.hide()
//                }
//            })

            if let httpResponse = response as? HTTPURLResponse {
                print("🔄 Response Status Code: \(httpResponse.statusCode)")
            }

            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                }
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("📩 Response Data: \(jsonString)")
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    // MARK: - Upload Image (Multipart Form Data)
    func uploadImage<T: Decodable>(
            urlString: String,
            parameters: [String: Any],
            image: UIImage,
            in view: UIView? = nil,
            imageKey: String,
            imageName: String,
            completion: @escaping (Result<T, Error>) -> Void
        ) {
            
            DispatchQueue.main.async { [weak self] in
                if let view = view {
                    Loader.shared.show(in: view)
                }
            }
            guard let url = URL(string: urlString) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            print(parameters)
            print("📡 Request URL: \(urlString)")
            
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let boundary = UUID().uuidString
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            var body = Data()
            
            for (key, value) in parameters {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
            
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"\(imageName)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
            
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = body
            
            print(request)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async { [weak self] in
                    if let _ = view {
                        Loader.shared.hide()
                    }
                }
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.noData))
                    }
                    return
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📩 Response Data: \(jsonString)")
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.decodingError(error)))
                    }
                }
            }
            task.resume()
        }
}
