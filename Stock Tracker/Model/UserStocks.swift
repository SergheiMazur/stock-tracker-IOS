//
//  UserSticks.swift
//  Stock Tracker
//
//  Created by Serghei Mazur on 2018-06-21.
//  Copyright © 2018 Serghei Mazur. All rights reserved.
//

import Foundation

class UserStocks {
    var id: Int?
    var user_id: Int?
    var stock_id: Int?
    var created_at: String?
    var updated_at: String?
    
    init(id: Int, user_id: Int, stock_id: Int, created_at: String, updated_at: String) {
        self.id = id
        self.user_id = user_id
        self.stock_id = stock_id
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
}
