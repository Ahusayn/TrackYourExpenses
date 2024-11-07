//
//  TransactioonListModel.swift
//  TrackYourExpenses
//
//  Created by mac on 29/10/2024.
//


import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transactions]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListModel: ObservableObject {
    @Published var transaction: [Transactions] = []
    
    init() {
        getTransactions()
    }

    
    func getTransactions() {
            guard let url = URL(string: "https://api.jsonbin.io/v3/qs/672cf7f1e41b4d34e4504774") else {
                print("Invalid URL")
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    print("Error fetching data:", error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    return
                }
                
                do {
                    // Decode the data using TransactionResponse
                    let decodedData = try JSONDecoder().decode(TransactionResponse.self, from: data)
                    print("Decoded data: \(decodedData)")
                    DispatchQueue.main.async {
                        self?.transaction = decodedData.record
                    }
                } catch {
                    print("Error decoding data:", error.localizedDescription)
                }
            }
            
            task.resume()
        }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transaction.isEmpty else {return [:]}
        
        let groupedTransactions = TransactionGroup(grouping: transaction) { $0.month }
        
        return groupedTransactions
    }
    
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("Accumulate Transactions")
        
        // Check if the transaction list is empty
        guard !transaction.isEmpty else {
            print("No transactions available")
            return []
        }

        // Parse the start and end dates for transaction accumulation
        guard let startDate = "2024-02-01".dateParsed(),
              let endDate = "2024-12-11".dateParsed() else {
            print("Failed to parse dates")
            return []
        }

        let dateInterval = DateInterval(start: startDate, end: endDate)

        print("Date Interval:", dateInterval) // Check the date interval

        var sum: Double = 0.0
        var cumulativeSum: [(String, Double)] = []

        // Accumulate transactions for the specified date range
        for date in stride(from: dateInterval.start, through: dateInterval.end, by: 60 * 60 * 24) {
            let dailyExpenses = transaction.filter {
                Calendar.current.isDate($0.dateParsed, inSameDayAs: date)
            }
            
            // Calculate the daily total
            let dailyTotal = dailyExpenses.reduce(0) { $0 + $1.amount }

            print("\(date.formatted()): dailyTotal: \(dailyTotal)")

            // Update cumulative sum
            sum += dailyTotal
            sum = round(sum * 100) / 100 // Round to 2 decimal places

            // Append the formatted date and cumulative sum to the result
            cumulativeSum.append((DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none), sum))

            print("\(date.formatted()): cumulativeSum: \(sum)")
        }

        return cumulativeSum
    }

    
}
