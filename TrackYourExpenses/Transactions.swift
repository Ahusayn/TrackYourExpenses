//
//  Transactions.swift
//  TrackYourExpenses
//
//  Created by mac on 28/10/2024.
//

import Foundation
import SwiftUIFontIcon


struct Transactions: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let date: String
    let amount: Double
    let institution: String
    var category: String
    var categoryId: Int
    let description: String
    let type: TransactionType.RawValue
    
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var dateParsed: Date {
        date.dateParsed()!
    }
    
    
    var icon: FontAwesomeCode {
        if  let category = Category.allCategories.first(where: { $0.id == categoryId}) {
            return category.icon
        }
        
        return .question
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
   
}

enum TransactionType: String, Codable {
    case debit = "debit"
    case credit = "credit"
}

struct TransactionResponse: Codable {
    let record: [Transactions]
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
}




extension Category {
    static let allCategories: [Category] = [
        Category(id: 101, name: "Food & Dining", icon: .utensils),
        Category(id: 102, name: "Shopping", icon: .shopping_cart),
        Category(id: 103, name: "Home", icon: .home),
        Category(id: 104, name: "Fees & Charges", icon: .book),
        Category(id: 105, name: "Auto & Transport", icon: .bus),
        Category(id: 106, name: "Entertainment", icon: .film),
        Category(id: 107, name: "Bills & Utilities", icon: .money_bill),
        Category(id: 108, name: "Miscellaneous", icon: .check) 
    ]
}
