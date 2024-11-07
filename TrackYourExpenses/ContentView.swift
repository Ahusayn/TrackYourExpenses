//
//  ContentView.swift
//  TrackYourExpenses
//
//  Created by mac on 28/10/2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListModel: TransactionListModel
    
    
    var body: some View {
      
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    //MARK: - Title
                    Text("✌🏿 Hey Abdul! ")
                        .font(.title2)
                        .foregroundColor(.UI)
                    
                    //MARK: - Charts
                    let data = transactionListModel.accumulateTransactions()
                    
                    if !data.isEmpty  {
                        let expensesTotal  = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(expensesTotal.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                
                                LineChart()
                            }
                            .background(Color(UIColor.systemBackground))
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.borders, foregroundColor: ColorGradient(Color.link.opacity(0.4), .link)))
                        .frame(height: 300)
      
                    }
                   
                    
                    Spacer()
                    
                    
                //MARK: - Recent Transaction
                    RecentTransactionList()
            
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            //MARK: - Notification Item
            .toolbar {
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.UIcolor, .UI)
                }
            }
//            .onAppear() {
//                transactionListModel.getTransactions()
//                print(transactionListModel.transaction) // Check if transactions are being loaded 
//            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
        
}

#Preview {
    ContentView()
        .environmentObject(TransactionListModel())
        
}
