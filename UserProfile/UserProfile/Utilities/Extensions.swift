//
//  Extensions.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension String {
    func getAsDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: self) ?? Date()
    }
}


