//
//  Extensions.swift
//  Journal.it
//
//  Created by Mark Howard on 02/02/2022.
//

import Foundation

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
