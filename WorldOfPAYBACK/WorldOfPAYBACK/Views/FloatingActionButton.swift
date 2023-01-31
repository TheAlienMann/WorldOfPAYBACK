//
//  FloatingActionButton.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct FloatingActionButton<ImageView: View>: ViewModifier {
  let color: Color
  let image: ImageView
  let action: () -> Void
  
  private let size: CGFloat = 60
  private let margin: CGFloat = 15
  
  func body(content: Content) -> some View {
    GeometryReader { geo in
      ZStack {
        Color.clear
        content
        button(geo)
      }
    }
  }
  
  @ViewBuilder private func button(_ geo: GeometryProxy) -> some View {
    image
      .imageScale(.large)
      .frame(width: size, height: size)
      .background(Circle().fill(color))
      .foregroundColor(.white)
      .shadow(color: .gray, radius: 2, x: 1, y: 1)
      .onTapGesture(perform: action)
      .offset(x: (geo.size.width - size) / 2 - margin,
              y: (geo.size.height - size) / 2 - margin)
  }
}

extension View {
  func floatingActionButton<ImageView: View>(
    color: Color,
    image: ImageView,
    action: @escaping () -> Void) -> some View {
    self.modifier(FloatingActionButton(color: color,
                                       image: image,
                                       action: action))
  }
}

struct FABTest: View {
  @State private var noRows = 9
  @Binding var isOpen: Bool
  
  var body: some View {
    List(Array(1...noRows), id: \.self) { index in
      Text("Row \(index)")
    }
    .floatingActionButton(color: .blue,
                          image: Image(systemName: isOpen ? "x.circle" : "switch.2")
                            .foregroundColor(.white)) {
      isOpen.toggle()
    }
  }
}

struct FABTest_Previews: PreviewProvider {
  static var previews: some View {
    FABTest(isOpen: .constant(false))
  }
}
