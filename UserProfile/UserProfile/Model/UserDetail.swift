//
//  UserDetail.swift
//  UserProfile
//
//  Created by Elancheran, Ravi on 04/07/21.
//

import UIKit

struct UserDetail: Codable {
    var name: String
    var email: String
    var age: Int
    var gender: Gender
    var phone: String
    var picture: String
    var favoriteColor: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case email
        case age
        case gender
        case phone
        case picture
        case favoriteColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.age = try container.decode(Int.self, forKey: .age)
        
        let gender = try container.decode(String.self, forKey: .gender).lowercased()
        self.gender = Gender(rawValue: gender) ?? .male
        self.phone = try container.decode(String.self, forKey: .phone)
        self.picture = try container.decode(String.self, forKey: .picture)
        self.favoriteColor = try container.decodeIfPresent(String.self, forKey: .favoriteColor)
    }
    
    init() {
        self.name = ""
        self.email = ""
        self.age = 0
        self.gender = .male
        self.picture = ""
        self.phone = ""
    }
}

enum Gender: String, Codable {
    case male
    case female
    
    var symbol: String {
        switch self {
        case .male:
            return "M"
        case .female:
            return "F"
        }
    }
    
    var image: UIImage {
        switch self {
        case .male:
            return UIImage(named: "male") ?? UIImage()
        case .female:
            return UIImage(named: "female") ?? UIImage()
        }
    }
}
