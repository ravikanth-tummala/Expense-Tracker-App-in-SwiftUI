//
//  TranscationModel.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 04/07/22.
//

import Foundation
import SwiftUIFontIcon

struct Transaction:Identifiable,Decodable,Hashable{
    let id:Int
    let date:String
    let institution:String
    let account:String
    var merchant:String

    let amount:Double
    let type:TranscationType.RawValue
    var categoryId:Int
    var category:String
    let isPending:Bool
    var isTransfer:Bool
    var isExpense:Bool
    var isEdited:Bool
    
    var dateParse:Date {
        date.dateParse()
    }
    
    var signedAmount: Double {
        return type == TranscationType.credit.rawValue ? amount: -amount
    }

    var icon:FontAwesomeCode {
        if let category = Category.All.first(where: {$0.id == categoryId }){
            return category.icon
        }
        return .question
    }
    var month:String {
        dateParse.formatted(.dateTime.year().month(.wide))
    }
}

enum TranscationType:String{
    case debit = "debit"
    case credit = "credit"
}


struct Category{
    let id:Int
    let name:String
    let icon:FontAwesomeCode
    var mainCategoryId:Int?
}

extension Category{
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertaiment = Category(id: 3, name: "Entertaiment", icon: .file)
    static let feeAndCharges = Category(id: 4, name: "Fee & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category(id: 6, name: "Home", icon: .home)
    static let income = Category(id: 7, name: "Income", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: .shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: .exchange_alt)

    static let publiTransportation = Category(id: 101, name: "Public Transportation", icon: .bus,mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi,mainCategoryId: 1)
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt,mainCategoryId: 2)
    static let moviesAndDVDS = Category(id: 301, name: "Movies & DVDS", icon: .file,mainCategoryId: 3)
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: .hand_holding_usd,mainCategoryId: 4)
    static let groceries = Category(id: 501, name: "Groceries", icon: .shopping_basket,mainCategoryId: 5)
    static let restaurants = Category(id: 502, name: "Restaurants", icon: .utensils,mainCategoryId: 5)
    static let rent = Category(id: 601, name: "Rent", icon: .house_user,mainCategoryId: 6)
    static let homeSupplies = Category(id: 602, name: "Home Supplies", icon: .lightbulb,mainCategoryId: 6)
    static let payCheque = Category(id: 701, name: "Pay Cheque", icon: .dollar_sign,mainCategoryId: 7)
    static let software = Category(id: 801, name: "Software", icon: .icons,mainCategoryId: 8)
    static let creditCardpayment = Category(id: 901, name: "Credit Card Payment", icon: .exchange_alt,mainCategoryId: 9)
}

extension Category{
    static let categories:[Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertaiment,
        .feeAndCharges,
        .foodAndDining,
        .home,
        .income,
        .shopping,
        .transfer
    ]
    
    static let subCategories:[Category] = [
        .publiTransportation,
        .taxi,
        .mobilePhone,
        .moviesAndDVDS,
        .bankFee,
        .groceries,
        .restaurants,
        .restaurants,
        .homeSupplies,
        .payCheque,
        .software,
        .creditCardpayment
    ]
    
    static let All:[Category] = categories + subCategories


}
