//
//  AsyncImage.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import SwiftUI
import RxSwift

struct AsyncImage: View {
    @State private var uiImage: UIImage? = nil
    let url: URL?
    
    private let viewModel: ItemsViewModel
    private let disposeBag = DisposeBag()
    
    init(url: URL?, viewModel: ItemsViewModel) {
        self.url = url
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Color.gray
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    func loadImage() {
        guard let url = url else { return }
        
        viewModel.fetchImage(url: url)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { image in
                self.uiImage = image
            })
            .disposed(by: disposeBag)
    }
}

#Preview {
    AsyncImage(url: URL(string: "https://via.placeholder.com/150"),
               viewModel: ItemsViewModel(dataService: DataService()))
        .frame(width: 100, height: 100)
}
