//
//  TransactionList.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 07/07/22.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionVM: TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
                //MARK: Transaction group
                ForEach(Array(transactionVM.groupTransactionByMonth()),id: \.key){ month, transcations in
                    
                    Section {
                        ForEach(transcations) { transcation in
                                TransactionRow(trancation: transcation)
                        }
                    } header: {
                        //MARK: Transaction Month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)

                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionVM:TransactionListViewModel = {
       let transactionListVM = TransactionListViewModel()
        transactionListVM.transacations = transcationListPreview
        return transactionListVM
    }()

    static var previews: some View {
        TransactionList()
            .environmentObject(transactionVM)
    }
}
