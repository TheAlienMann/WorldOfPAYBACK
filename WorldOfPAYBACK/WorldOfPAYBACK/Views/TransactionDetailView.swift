//
//  TransactionDetailView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct TransactionDetailView: View {
  let transaction: Item
  
  var body: some View {
    Text(transaction.partnerDisplayName)
      .navigationTitle("Some Title for Now")
      .navigationBarTitleDisplayMode(.inline)
  }
}

struct TransactionDetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      TransactionDetailView(transaction: Item(partnerDisplayName: "", alias: Alias(reference: ""), category: Categories.categoryOne, transactionDetail: TransactionDetail(description: "", bookingDate: Date(), value: .init(amount: 21, currency: ""))))
    }
  }
}
