//
//  ExpenseTrackingApp.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 04/07/22.
//

import SwiftUI

@main
struct ExpenseTrackingApp: App {
    
    @StateObject var transcationListVM =  TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transcationListVM)
        }
    }
}
