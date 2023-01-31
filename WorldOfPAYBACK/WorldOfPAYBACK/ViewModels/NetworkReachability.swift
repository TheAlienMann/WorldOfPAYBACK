//
//  NetworkReachability.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import Foundation
import Network
import Combine

class NetworkReachability: ObservableObject {
  private let networkMonitor = NWPathMonitor()
  private let workerQueue = DispatchQueue(label: "com.payback.network.monitor")
  var isConnected = false

  init() {
    networkMonitor.pathUpdateHandler = { path in
      self.isConnected = path.status == .satisfied
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
    networkMonitor.start(queue: workerQueue)
  }
}
