//
//  File.swift
//  
//
//  Created by Bills on 02/04/2023.
//

import Foundation
import Combine
import Model

internal extension EventListViewModel {
    func fetchEvents() {
        isLoading = true
        eventListUseCase
            .fetchEvents(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    print("Success: \(#function) \(self.currentPage)")
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                if (self.currentPage == 0){
                    self.events = value
                } else {
                    self.events = self.mergeEvents(self.events, value)
                    if (value.isEmpty){
                        self.isLoadMoreable = false
                    }
                }
                self.totalItem = self.events.flatMap { $0.1 }.count
            })
            .store(in: &cancellables)
    }
    
    func mergeEvents(_ dict1: [(Date, [EventEntity.EventModel])], _ dict2: [(Date, [EventEntity.EventModel])]) -> [(Date, [EventEntity.EventModel])] {
        var mergedDict: [(Date, [EventEntity.EventModel])] = []
        let allDates = Set(dict1.map { $0.0 } + dict2.map { $0.0 })
        for date in allDates {
            let events1 = dict1.filter { $0.0 == date }.flatMap { $0.1 }
            let events2 = dict2.filter { $0.0 == date }.flatMap { $0.1 }
            let mergedEvents = events1 + events2
            
            mergedDict.append((date, mergedEvents))
        }
        return mergedDict.sorted(by: {$0.0 > $1.0})
    }
}
