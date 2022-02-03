//
//  APIPath.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

struct URLPath {
    
    var userName: String
    
    var followersUrl: String {
        return "\(Environment().baseUrl)/users/\(userName)/followers"
    }
}

    


