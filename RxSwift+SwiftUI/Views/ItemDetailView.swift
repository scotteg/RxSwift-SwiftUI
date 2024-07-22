//
//  ItemDetailView.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: item.url),
                       viewModel: ItemsViewModel(dataService: DataService()))
                .frame(width: 100, height: 100)
            Text(item.title)
                .font(.largeTitle)
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    ItemDetailView(item: Item(id: 1,
                              title: "Sample Item",
                              url: "https://via.placeholder.com/150"))
}
