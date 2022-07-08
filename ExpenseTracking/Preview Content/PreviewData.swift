//
//  PreviewData.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 05/07/22.
//

import Foundation

var transcationpreviewData = Transaction(id: 1, date: "05/07/1990", institution: "Icfai", account: "Visa Icfai", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 001, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)


var transcationListPreview = [Transaction](repeating: transcationpreviewData, count: 10)
