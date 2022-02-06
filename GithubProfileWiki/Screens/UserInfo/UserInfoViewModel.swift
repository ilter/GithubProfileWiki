//
//  UserInfoViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 5.02.2022.
//

import Foundation

class UserInfoViewModel {
    func fetchUserInfo(userName: String, param: [String: Any], completion: @escaping (User?, Error?) -> ()) {
        let request = UserAPI(userName: userName)
        
        let apiService = APIService(apiRequest: request)
        apiService.submitRequest(requestData: param) { (model, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
}
