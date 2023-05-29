//
//  APIService.swift
//  Github Project
//
//  Created by Menaim on 03/01/2022.
//

import Foundation
class APIService {
    
    static let sharedService = APIService()
    
    func getRepositories(completion: @escaping(_ repositories: [Repository]?, _ error: Error? ) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/repositories") else {return}
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {return}
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([Repository].self, from: data)
                debugPrint(response)
                completion(response, nil)
                
            }
            catch {
                debugPrint(error.localizedDescription)
                completion(nil, error)
            }

        }
        task.resume()
    }
}
