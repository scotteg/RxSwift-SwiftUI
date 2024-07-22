//
//  MockDataService.swift
//  RxSwift+SwiftUITests
//
//  Created by Scott Gardner on 7/22/24.
//

import RxSwift
import UIKit
@testable import RxSwift_SwiftUI

class MockDataService: DataServiceProtocol {
    var itemsSubject = PublishSubject<[Item]>()
    var imageSubject = PublishSubject<UIImage?>()
    
    func fetchItems() -> Observable<[Item]> {
        itemsSubject.asObservable()
    }
    
    func fetchImage(from url: URL) -> Observable<UIImage?> {
        imageSubject.asObservable()
    }
}
