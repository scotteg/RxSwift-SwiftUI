//
//  ItemsListView.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import SwiftUI
import RxSwift

struct ItemsListView: View {
    @State private var viewModel: ItemsViewModel

    init(viewModel: ItemsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)) {
                        HStack {
                            AsyncImage(url: URL(string: item.url),
                                       viewModel: viewModel)
                                .frame(width: 50, height: 50)
                            Text(item.title)
                        }
                    }
                }
                .navigationTitle("Items")
                .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Error"),
                          message: Text(errorMessage),
                          dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

#Preview {
    ItemsListView(viewModel: ItemsViewModel(dataService: DataService()))
}
