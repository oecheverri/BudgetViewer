//
//  UserLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-23.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let user: User
}

struct UserLoader {
    
    func loadUser(callback: @escaping (User?, Error?) -> Void) {
        let loader = EndpointLoader<UserResponse>()
        loader.loadDataFrom(endpoint: "/user") { result in
            switch result {
                case .Success(let userResponse):
                    callback(userResponse.user, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
}
