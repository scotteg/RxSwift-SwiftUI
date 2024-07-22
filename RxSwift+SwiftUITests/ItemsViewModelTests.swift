//
//  ItemsViewModelTests.swift
//  RxSwift+SwiftUITests
//
//  Created by Scott Gardner on 7/22/24.
//

import XCTest
import RxSwift
@testable import RxSwift_SwiftUI

class ItemsViewModelTests: XCTestCase {
    var mockDataService: MockDataService!
    var viewModel: ItemsViewModel!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        viewModel = ItemsViewModel(dataService: mockDataService)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        mockDataService = nil
        viewModel = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testFetchItems() throws {
        let expectation = XCTestExpectation(description: "Fetch items")
        let testItems = [Item(id: 1, title: "Test Item", url: "https://via.placeholder.com/150")]
        
        mockDataService.itemsSubject.onNext(testItems)
        viewModel.fetchItems()
        
        Task {
            try await Task.sleep(nanoseconds: 100_000_000)
            XCTAssertEqual(self.viewModel.items.count, testItems.count)
            XCTAssertEqual(self.viewModel.items.first?.title, testItems.first?.title)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchImage() throws {
        let imageURL = URL(string: "https://via.placeholder.com/150")!
        let testImage = UIImage()
        
        mockDataService.imageSubject.onNext(testImage)
        
        viewModel.fetchImage(url: imageURL)
            .subscribe(onNext: { image in
                XCTAssertNotNil(image)
                XCTAssertEqual(image, testImage)
            })
            .disposed(by: disposeBag)
    }
}
