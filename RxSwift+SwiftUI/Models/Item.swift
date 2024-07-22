//
//  Item.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import Foundation

struct Item: Identifiable, Decodable {
    let id: Int
    let title: String
    let url: String
}
