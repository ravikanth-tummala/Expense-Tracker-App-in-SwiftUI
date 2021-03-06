//
//  RecentTransactionList.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 06/07/22.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM:TransactionListViewModel
    
    var body: some View {
        VStack{
            HStack{
                // MARK: Header Title
                Text("Recent Transaction")
                    .bold()
                
                Spacer()
                // MARK: Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing:4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            // MARK: Recent Transaction List
            ForEach(Array(transactionListVM.transacations.prefix(5).enumerated()),id: \.element) { index, transaction in
                
                TransactionRow(trancation: transaction)
                Divider()
                    .opacity(index == 4 ? 0: 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    
    static let transactionVM:TransactionListViewModel = {
       let transactionListVM = TransactionListViewModel()
        transactionListVM.transacations = transcationListPreview
        return transactionListVM
    }()
    
    
    
    static var previews: some View {
        RecentTransactionList()
            .environmentObject(transactionVM)
    }
}
