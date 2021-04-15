//
//  DogsListModel.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation

enum DogStatus: String, Decodable {
    case success
    case error
}

// Using a custom decoder here and in the DogDetailsModel because the api can
// return a String for `message` if it has an error, or a dictionary if it is
// successful.
struct DogsListModel: Decodable {
    let data: [String: [String]]?
    let errorMessage: String?
    let status: DogStatus
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try? container.decodeIfPresent([String: [String]].self, forKey: .message)
        self.errorMessage = try? container.decodeIfPresent(String.self, forKey: .message)
        self.status = try container.decode(DogStatus.self, forKey: .status)
    }
}
