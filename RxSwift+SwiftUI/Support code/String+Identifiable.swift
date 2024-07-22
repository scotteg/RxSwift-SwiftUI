//
//  String+Identifiable.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/22/24.
//

import Foundation

extension String: Identifiable {
    public var id: String {
        self
    }
}
