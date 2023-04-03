//
//  File.swift
//  
//
//  Created by Bills on 01/04/2023.
//

import Foundation
import Networking

struct EventRequest: NetworkingRequest {
    var queryParams: [URLQueryItem]?    
    var path: String { "/event/list" }
    var headers: [String: String] = [:]
}
