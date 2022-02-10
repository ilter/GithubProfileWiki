//
//  FollowersListViewModel.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

class FollowersListViewModel {
    func fetchFollowers(userName: String, param: [String: Any], completion: @escaping (Followers?, Error?) -> ()) {
        let request = FollowersAPI(userName: userName)
        
        let apiService = APIService(apiRequest: request)
        apiService.submitRequest(requestData: param) { (model, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(model, nil)
            }
        }
    }
    
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
