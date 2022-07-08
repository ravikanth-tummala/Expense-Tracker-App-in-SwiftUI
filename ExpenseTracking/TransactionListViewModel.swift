//
//  TransactionListViewModel.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 05/07/22.
//

import Foundation
import Combine
import Collections

typealias TransacationGroup = OrderedDictionary<String,[Transaction]>
typealias TransactionPrefixSum = [(String,Double)]

final class TransactionListViewModel:ObservableObject {
    
    @Published var transacations:[Transaction] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        getTransaction()
    }
    
    func getTransaction(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
                switch completion {
                case .failure(let error):
                    print("Error fetching ",error.localizedDescription)
                case .finished:
                    print("Finished fetching transaction")
                }
            } receiveValue: { [weak self]results in
                self?.transacations = results
            }
            .store(in: &cancellable)
    }
    
    func groupTransactionByMonth() -> TransacationGroup{
        guard !transacations.isEmpty else {
            return [:]
        }
        let groupTrans = TransacationGroup(grouping: transacations) { $0.month }
        return groupTrans
    }
    
    func accumalateTransactions() -> TransactionPrefixSum{
        guard !transacations.isEmpty else { return []}
        
        let today = "07/07/2022".dateParse()
        let dateInterval = Calendar.current.dateInterval(of: .month,for:today)!
        print(dateInterval)
        
        var sum:Double = .zero
        var cumulative = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today,by: 60 * 60 * 24){
            let dailyExpense = transacations.filter{$0.dateParse == date && $0.isExpense }
            let dailyTotal = dailyExpense.reduce(0) {$0 - $1.signedAmount }
            
            sum += dailyTotal
            cumulative.append((date.formatted(),sum))
        }
        return cumulative
    }
    
}
