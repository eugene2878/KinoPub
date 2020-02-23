//
//  BookmarksInteractor.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 06/03/2020.
//  Copyright (c) 2020 Maksim Kolesnik. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Combine

public final class BookmarksInteractor {
    public weak var output: BookmarksInteractorOutput?
    private let networkService: NetworkServiceFactory
    public init(networkService: NetworkServiceFactory) {
        self.networkService = networkService
    }
}

// MARK: - BookmarksInteractorInput

extension BookmarksInteractor: BookmarksInteractorInput {
    public func requestBookmarks() -> AnyPublisher<[Bookmark], Never> {
        return networkService.lazyNetworkService
            .execute(BookmarksRequest())
            .map({ $0.items })
            .catch({ (_) -> Empty<[Bookmark], Never> in
                return Empty()
            })
            .eraseToAnyPublisher()
    }

    public func interact() {

    }

}
