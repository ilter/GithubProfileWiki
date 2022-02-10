//
//  Date+Extension.swift
//  GithubProfileWiki
//
//  Created by ilter on 10.02.2022.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
