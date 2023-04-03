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
    func onItemAppear(_ index: Int){
        if (isLoading || !isLoadMoreable){
            return
        }
        if (index == totalItem - 1){
            loadMore()
        }
    }
    
    private func loadMore(){
        currentPage = currentPage + 1
        fetchEvents()
    }
}
