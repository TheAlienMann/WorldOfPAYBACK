//
//  NoNetworkView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct NoNetworkView: View {
  var body: some View {
    VStack {
      Image(systemName: "wifi.exclamationmark")
        .font(.system(size: 64.0))
      Text("internet")
        .font(.system(size: 32))
        .foregroundColor(.blue)
    }
  }
}

struct NoNetworkView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      NoNetworkView()
        .environment(\.locale, .init(identifier: "en"))
      
      NoNetworkView()
        .environment(\.locale, .init(identifier: "de"))
    }
  }
}
