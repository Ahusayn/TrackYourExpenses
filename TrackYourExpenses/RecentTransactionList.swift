//
//  RecentTransactionList.swift
//  TrackYourExpenses
//
//  Created by mac on 29/10/2024.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject  var transactionListModel : TransactionListModel
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                    .foregroundColor(.UI)
                
                Spacer()
                
                //MARK: - Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                        
                    }
                    .foregroundColor(.link)
                }
            }
            .padding(.top)
            
            //MARK: - Transactions
            ForEach(Array(transactionListModel.transaction.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionsAll(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
            
        }
        .padding()
        .background(Color.background)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.4), radius: 10, x: 0, y: 5)
        
    }
}

#Preview {
    RecentTransactionList()
        .environmentObject(TransactionListModel())
}
