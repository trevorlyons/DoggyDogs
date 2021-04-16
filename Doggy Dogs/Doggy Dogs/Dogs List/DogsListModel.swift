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

// I was thinking of making one model that would handle both the initial dogs list
// call, as well as the dog images call due to the responses being so similar. The
// below implementation works and removes some of the code duplication of dealing
// with a failed response, but I ended up going with each handling it on their own
// as in the real world these models would most likely be more complex. I had also
// debated having the DogNetworking deal with this scenario directly but I thought
// that would make the underlying networking less flexible for future growth. 👨‍💻
//
//
//    struct Blah<T: Decodable>: Decodable {
//        let data: T?
//        let errorMessage: String?
//        let status: DogStatus
//
//        enum CodingKeys: String, CodingKey {
//            case message, status
//        }
//
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            self.data = try? container.decodeIfPresent(T.self, forKey: .message)
//            self.errorMessage = try? container.decodeIfPresent(String.self, forKey: .message)
//            self.status = try container.decode(DogStatus.self, forKey: .status)
//        }
//    }
