//
//  SeasonInteractor.swift
//  KinoPub
//
//  Created by Maksim Kolesnik on 07/03/2020.
//  Copyright (c) 2020 Maksim Kolesnik. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Combine
import Foundation

public final class SeasonInteractor {
    public weak var output: SeasonInteractorOutput?
    private let downloadService: DownloadServiceFactory
    private let _downloadService: DownloadService
    private let networkService: NetworkServiceFactory
    public init(downloadService: DownloadServiceFactory,
                networkService: NetworkServiceFactory) {
        self.downloadService = downloadService
        self._downloadService = downloadService.lazyDownloadService
        self.networkService = networkService
    }

}

// MARK: - SeasonInteractorInput

extension SeasonInteractor: SeasonInteractorInput {

    public func download(_ episode: Episode) -> AnyPublisher<Progress, Error> {
        let subject = PassthroughSubject<Progress, Error>()

        if let http = episode.files.first(where: { $0.qualityID == 1 })?.url.http,
            let url = URL(string: http) {
            self.downloadService.lazyDownloadService
                .download(
                    url: url,
                    progress: { progress in
                        subject.send(progress)
                    },
                    completionHandler: { (data) in
                        switch data.result {
                        case .success(let data):
                            print("data")
                            print(data)
                            subject.send(completion: .finished)
                        case .failure(let error):
                            subject.send(completion: .failure(error))
                        }
                    }
            )
        }
        return subject.eraseToAnyPublisher()
    }

    private func head(file path: String)-> AnyPublisher<UInt, Error> {
        return CurrentValueSubject(0).eraseToAnyPublisher()
    }

    public func requestEpisodes(_ model: Season) -> AnyPublisher<[EpisodeViewModel], Never> {
        let models = model.episodes.map({ (episode) -> EpisodeViewModel in
            return EpisodeViewModel(
                model: episode,
                state: .startDownload,
                downloadAction: { [weak self] (viewModel) -> AnyPublisher<Progress, Error> in
                    guard let self = self else { return Empty().eraseToAnyPublisher() }
                    return self.download(viewModel.model)
                },
                cancelAction: { [weak self] (viewModel) in
                    guard let self = self else { return }
                    if let http = viewModel.model.files.first(where: { $0.qualityID == 1 })?.url.http,
                    let url = URL(string: http) {
                        self.downloadService.lazyDownloadService.cancel(url: url)
                    }
                }
            )
        })
        return Just(models).eraseToAnyPublisher()
    }

    public func interact() {

    }

}
