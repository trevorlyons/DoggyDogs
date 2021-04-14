//
//  DogsListModel.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 14/04/2021.
//

import Foundation

struct DogsListModel: Decodable {
    let message: [String: [String]]
    let status: Bool
}
