//
//  DogDetailsModel.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation

// Repeating more or less the same custom decoder from DogListModel to make sure the message key
// is properly decoded.
struct DogDetailsModel: Decodable {
    let dogImages: [String]?
    let errorMessage: String?
    let status: DogStatus
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dogImages = try? container.decodeIfPresent([String].self, forKey: .message)
        self.errorMessage = try? container.decodeIfPresent(String.self, forKey: .message)
        self.status = try container.decode(DogStatus.self, forKey: .status)
    }
}
