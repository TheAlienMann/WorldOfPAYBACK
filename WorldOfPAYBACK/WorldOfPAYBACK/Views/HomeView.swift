//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct HomeView: View {
  @StateObject var itemsViewModel = ItemsViewModel()
  @State var isMenuOpen = false
  @State var toast: ToastModel? = nil
  
  var body: some View {
    ZStack {
      ScrollView {
        ForEach(itemsViewModel.filterredTransactions, id: \.id) { items in
          HStack(alignment: .center) {
            NavigationLink(destination: TransactionDetailView(transaction: items)) {
              TransactionView(bookingDate: items.transactionDetail.bookingDate.toString(),
                              partnerDisplayName: items.partnerDisplayName,
                              transactionDiscription: items.transactionDetail.description, valueAmount: "\(items.transactionDetail.value.amount)", valueCurrency: items.transactionDetail.value.currency)
              
            }
          }
          .padding(.vertical, 2.0)
        }
      }
      .onAppear {
        itemsViewModel.filterredTransactions = itemsViewModel.items
      }
      .disabled(isMenuOpen ? true : false)
      ZStack {
        VStack {
          Spacer()
          ForEach(1..<itemsViewModel.numberOfCategories + 1) { categoryNumber in
            ZStack {
              VStack {
                HStack {
                  Spacer()
                  Button {
                    isMenuOpen = false
                    self.itemsViewModel.filterredTransactions = itemsViewModel.sortTransactions().filter { item in
                      item.category.rawValue == categoryNumber
                    }
                  } label: {
                    Text("Gategory \(categoryNumber)")
                      .foregroundColor(.blue)
                      .background(Color.white)
                      .font(.system(size: 22, weight: .bold, design: .rounded))
                  }
                }
              }
            }
            .frame(height: 4, alignment: .trailing)
            .padding()
            .displayOnMenuOpen(isMenuOpen, offset: 0)
          }
        }
        .padding(.bottom, 80.0)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.clear)
      .floatingActionButton(color: .blue, image: Image(systemName: isMenuOpen ? "x.circle" : "switch.2").font(.title2)) {
        isMenuOpen.toggle()
      }
    }
    .onTapGesture {
      isMenuOpen = false
    }
    .navigationBarTitle("Transactions")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          itemsViewModel.filterredTransactions = itemsViewModel.items
        } label: {
          Image(systemName: "arrow.counterclockwise.circle")
        }
      }
      
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          itemsViewModel.filterredTransactions = itemsViewModel.sortTransactions()
        } label: {
          Image(systemName: "arrow.up.arrow.down.circle")
        }
      }
      ToolbarItem(placement: .bottomBar) {
        Button { } label: {
          Text("The Sum of Value is: \(itemsViewModel.filterredTransactions.map(\.transactionDetail.value.amount).reduce(0, +))")
        }
      }
    }
  }
}
