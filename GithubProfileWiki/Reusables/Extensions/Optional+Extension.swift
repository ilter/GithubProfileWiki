//
//  Optional+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 11.02.2022.
//

import Foundation

extension Swift.Optional where Wrapped == String {
    
}


protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil}
}
