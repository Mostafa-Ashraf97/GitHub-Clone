//
//  Repository.swift
//  Github Project
//
//  Created by Menaim on 03/01/2022.
//

import Foundation


struct Repository: Codable {
    
    let repositiryName: String?
    let owner: Owner?
    enum CodingKeys: String, CodingKey {
        case repositiryName = "name"
        case owner
    }
}

struct Owner: Codable {
    let ownerImage: String?
    
    enum CodingKeys: String, CodingKey {
        case ownerImage = "avatar_url"
    }
    
}
