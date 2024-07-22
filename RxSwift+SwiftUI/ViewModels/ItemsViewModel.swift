//
//  ItemsViewModel.swift
//  RxSwift+SwiftUI
//
//  Created by Scott Gardner on 7/21/24.
//

import Foundation
import RxSwift
import SwiftUI

@Observable
class ItemsViewModel {
    private let dataService: DataServiceProtocol
    private let disposeBag = DisposeBag()
    
    var items: [Item] = []
    var errorMessage: String?
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        fetchItems()
    }
    
    func fetchItems() {
        dataService.fetchItems()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] items in
                    self?.items = items
                },
                onError: { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchImage(url: URL) -> Observable<UIImage?> {
        return dataService.fetchImage(from: url)
            .observe(on: MainScheduler.instance)
            .catch { [weak self] error in
                self?.errorMessage = error.localizedDescription
                return Observable.just(nil)
            }
    }
}
