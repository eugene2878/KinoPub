//
//  ItemInteractor.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 07/03/2020.
//  Copyright (c) 2020 Maksim Kolesnik. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import Combine

public final class ItemInteractor {
    public weak var output: ItemInteractorOutput?

    private let networkService: NetworkServiceFactory
    public init(networkService: NetworkServiceFactory) {
        self.networkService = networkService
    }
}

// MARK: - ItemInteractorInput

extension ItemInteractor: ItemInteractorInput {

    public func interact() {

    }

    public func requestBookmark(model: Bookmark.Item) -> AnyPublisher<Item, Never> {
        self.networkService.lazyNetworkService
            .execute(ItemRequest(id: model.id))
            .compactMap({ $0.item })
            .catch({ (_) -> Empty<Item, Never> in
                return Empty()
            })
            .eraseToAnyPublisher()
    }

}
