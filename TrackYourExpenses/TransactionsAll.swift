//
//  TransactionsAll.swift
//  TrackYourExpenses
//
//  Created by mac on 29/10/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionsAll: View {
    var transaction: Transactions
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icons.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icons)
                }
            
            VStack(alignment: .leading, spacing: 8) {
                //MARK: - Transaction merchant
                Text(transaction.institution)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: - Transction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: - Transaction Date
                Text(transaction.date)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                
              
            }
            
            Spacer()
            
            //MARK: - Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.green : Color.red)
            

            
        }
        .padding([.top, .bottom], 8)
    }
    
}

#Preview {
    TransactionsAll(transaction: transactionPreviewData)
}
