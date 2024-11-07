//
//  TransactionList.swift
//  TrackYourExpenses
//
//  Created by mac on 05/11/2024.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListModel: TransactionListModel

    
    var body: some View {
        VStack {
            List {
                //MARK: - Transaction Groups
                ForEach(Array(transactionListModel.groupTransactionsByMonth()), id: \.key) { month, transactions in
                    Section {
                        //MARK: - Transaction List
                        ForEach(transactions) {
                            transactions in
                            TransactionsAll(transaction: transactions)
                        }
                    } header: {
                        //MARK: - Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    NavigationStack {
        TransactionList()
            .environmentObject(TransactionListModel())
    }
}
