//
//  ContentView.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 04/07/22.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    // MARK: Title
                    Text("OverView")
                        .font(.title)
                        .bold()
                    
                    // MARK: Chart
                    let data = transactionListVM.accumalateTransactions()
                    let totalExpense = data.last?.1 ?? 0
                    CardView {
                        VStack{
                            ChartLabel(totalExpense.formatted(.currency(code: "USD")),type: .title)
                            LineChart()
                        }
                        .background(Color.systemBackground)

                    }
                    .data(data)
                    .chartStyle(ChartStyle(backgroundColor: Color.systemBackground,
                                           foregroundColor: ColorGradient(Color.icon.opacity(0.4),Color.icon)))
                    .frame(height:300)
                    
                    
                    // MARK: Transaction list
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification icon
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionVM:TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transacations = transcationListPreview
        return transactionListVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionVM)
    }
}
