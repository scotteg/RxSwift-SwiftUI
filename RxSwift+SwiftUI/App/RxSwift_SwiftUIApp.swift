//
//  RxSwift_SwiftUIApp.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import SwiftUI

@main
struct RxSwift_SwiftUIApp: App {
    let dataService: DataServiceProtocol = DataService()
    
    var body: some Scene {
        WindowGroup {
            ItemsListView(viewModel: ItemsViewModel(dataService: dataService))
        }
    }
}
