//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

@main
struct WorldOfPAYBACKApp: App {
  @StateObject var networkReachability = NetworkReachability()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(networkReachability)
    }
  }
}
