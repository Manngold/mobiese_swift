import Foundation

class ApiManager {
    class func fetch(resource: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void){
        guard let url = URL(string: "\(resource)") else {
            print("URL is nil")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}
