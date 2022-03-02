//
//  DateConverterTests.swift
//  GithubProfileWikiTests
//
//  Created by ilter on 28.02.2022.
//

import XCTest
@testable import GithubProfileWiki

class DateConverterTests: XCTestCase {
    func test__itConvertsDateToDisplayCorrectly() {
        let mockDate = "2016-10-22T21:17:16Z"
        XCTAssertEqual("Oct 22, 2016", mockDate.convertDateToDisplayFormat())
    }
}

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)
    }

    func convertDateToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
