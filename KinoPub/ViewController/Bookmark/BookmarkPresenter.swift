//
//  BookmarkPresenter.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 07/03/2020.
//  Copyright (c) 2020 Maksim Kolesnik. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Combine

public final class BookmarkPresenter {

    // MARK: - Private

    internal weak var view: BookmarkPresenterOutput?
    private let interactor: BookmarkInteractorInput
    private let router: BookmarkRouterInput

    private var model: Bookmark?
    // MARK: - Initialization

    public init(interactor: BookmarkInteractorInput,
                router: BookmarkRouterInput) {
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - BookmarkViewOutput

extension BookmarkPresenter: BookmarkViewOutput {
    public func didSelect(model: Bookmark.Item) {
        router.didSelect(model: model)
    }

    public func didTriggerViewReadyEvent() {
        view?.setupInitialState()
    }

    public func requestBookmark() -> AnyPublisher<[Bookmark.Item], Never> {
        guard let model = self.model else { return Empty().eraseToAnyPublisher() }
        return interactor.requestBookmark(model: model)
    }

}

// MARK: - BookmarkInteractorOutput

extension BookmarkPresenter: BookmarkInteractorOutput {

}

// MARK: - BookmarkRouterOutput

extension BookmarkPresenter: BookmarkRouterOutput {

}

extension BookmarkPresenter: BookmarkPresenterInput {
    public func setupWith(_ model: Bookmark) {
        self.model = model
    }

}
