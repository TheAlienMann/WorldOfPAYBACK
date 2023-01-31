//
//  ContentView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var networkReachability: NetworkReachability
  @State var toast: ToastModel? = nil
  
  var body: some View {
    NavigationView {
      VStack {
        if networkReachability.isConnected {
          HomeView()
        } else {
          NoNetworkView()
        }
      }
      .onChange(of: networkReachability.isConnected) {_ in
        toast = ToastModel(type: .info, title: "Internet Connection", message: "You lost your Connection.")
      }
      .toastView(toast: $toast, edge: .bottom)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
