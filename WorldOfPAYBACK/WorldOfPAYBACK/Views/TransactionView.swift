//
//  TransactionView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct TransactionView: View {
  let bookingDate: String
  let partnerDisplayName: String
  let transactionDiscription: String?
  let valueAmount: String
  let valueCurrency: String
  var body: some View {
    HStack {
      VStack {
        Text(bookingDate)
        Text(partnerDisplayName)
        Text("\(transactionDiscription ?? "No Discription for this Item.")")
        Text(valueAmount)
        Text(valueCurrency)
      }
    }
    .frame(maxWidth: .infinity)
    .background(Color.yellow)
    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    .listRowBackground(Color.white.opacity(0))
    .cornerRadius(30)
  }
}

struct TransactionView_Previews: PreviewProvider {
  static var previews: some View {
    TransactionView(bookingDate: "some Date",
                    partnerDisplayName: "OTTO",
                    transactionDiscription: nil,
                    valueAmount: "20022",
                    valueCurrency: "Euro")
      .previewLayout(.sizeThatFits)
  }
}
