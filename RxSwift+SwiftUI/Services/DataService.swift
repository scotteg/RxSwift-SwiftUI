//
//  DataService.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol DataServiceProtocol {
    func fetchItems() -> Observable<[Item]>
    func fetchImage(from url: URL) -> Observable<UIImage?>
}

class DataService: DataServiceProtocol {
    func fetchItems() -> Observable<[Item]> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .map { data in
                let items = try JSONDecoder().decode([Item].self, from: data)
                return items
            }
//            .catchAndReturn([])
    }
    
    func fetchImage(from url: URL) -> Observable<UIImage?> {
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { data in
                return UIImage(data: data)
            }
//            .catchAndReturn(nil)
    }
}
