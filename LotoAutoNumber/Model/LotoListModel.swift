//
//  LotoListModel.swift
//  Loto6Number
//
//  Created by Hyungjun Kim on 2021/05/01.
//

import Foundation

struct LotoList: Codable {
    var list_number: String
    var list_date: String
    var number1: String
    var number2: String
    var number3: String
    var number4: String
    var number5: String
    var number6: String
    var bonus: String
    
    private enum CodingKeys: String, CodingKey {
        case list_number = "list_number"
        case list_date = "list_date"
        case number1 = "number1"
        case number2 = "number2"
        case number3 = "number3"
        case number4 = "number4"
        case number5 = "number5"
        case number6 = "number6"
        case bonus = "bonus"
    }
}
