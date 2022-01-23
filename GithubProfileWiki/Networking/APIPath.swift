//
//  APIPath.swift
//  GithubProfileWiki
//
//  Created by ilter on 23.01.2022.
//

import Foundation

#if DEBUG
let environment = Environment.development
#else
let environment = Environment.production
#endif


private let baseURL = environment.baseUrl()

struct Path {
    
    var userName: String
    
    var path: String {
            return "\(baseURL)/users/\(userName)/followers"
        }
}

    


