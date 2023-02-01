//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var networkReachability: NetworkReachability
  @StateObject var transactionsViewModel: TransactionsViewModel
  @State var toast: ToastModel? = nil
  
  var body: some View {
    NavigationView {
      VStack {
        if networkReachability.isConnected {
          HomeView(transactionsViewModel: TransactionsViewModel())
        } else {
          NoNetworkView()
        }
      }
      .onChange(of: networkReachability.isConnected) { connected in
        if connected {
          toast = ToastModel(type: .success, title: "Internet Connection", message: "You are Connected.")
        } else {
          toast = ToastModel(type: .error, title: "Internet Connection", message: "You lost your Internet Connection.")
        }
      }
      .toastView(toast: $toast, edge: .bottom)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(transactionsViewModel: TransactionsViewModel())
  }
}
