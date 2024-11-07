//
//  TransactionPreviewData.swift
//  TrackYourExpenses
//
//  Created by mac on 29/10/2024.
//

import Foundation

var transactionPreviewData = Transactions(id: 101, name: "Grocery", date: "12/02/222", amount: 15.20, institution: "Green Salads", category: "Food", categoryId: 101, description: "Lunch at Green Salad", type: TransactionType.debit.rawValue)

var transactionListPreview =  [Transactions](repeating: transactionPreviewData, count: 15)
