//
//  TranscationRow.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 05/07/22.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var trancation:Transaction
    
    var body: some View {
        HStack(spacing:20){
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: trancation.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6){
                //MARK: Trancation merchant
                Text(trancation.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Trancation category
                Text(trancation.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                  
                //MARK: Trancation Date
                Text(trancation.dateParse,format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)

            }
            
            Spacer()
            
            //MARK: Trancation Amount
            Text(trancation.signedAmount,format: .currency(code: "USD"))
                .bold()
                .foregroundColor(trancation.type == TranscationType.credit.rawValue ?  Color.text : .primary)

            
        }
        .padding([.top,.bottom], 8)
    }
}

struct TranscationRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(trancation: transcationpreviewData)
    }
}
