//
//  CustomMenu.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct CustomMenu: View {
  @State var isMenuOpen = false
  let numberOfCategories: Int
  private let margin: CGFloat = 15
  
  var body: some View {
    NavigationView {
      ZStack {
        List(Array(1...25), id: \.self) { index in
          Text("Row \(index)")
        }
        ZStack {
          GeometryReader { proxy in
            ForEach(1..<numberOfCategories + 1) { categoryNumber in
              ZStack {
                Button(action: {
                  isMenuOpen = false
                }) {
                  Text("Gategory \(categoryNumber)")
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                }
              }
              .offset(x: (proxy.size.width) * 0.67,
                      y: (proxy.size.height) * 0.67)
              .displayOnMenuOpen(isMenuOpen, offset: CGFloat(50 * categoryNumber))
            }
          }
        }
        .onTapGesture {
          print(#line, #file.components(separatedBy: "/").last!, "tapped")
          isMenuOpen = false
        }
        .floatingActionButton(color: Color.blue, image: Image(systemName: "switch.2")) {
          isMenuOpen.toggle()
        }
      }
      .navigationBarTitle("Transactions")
      .navigationBarTitleDisplayMode(.inline)
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct DisplayOnOpenMenuViewModifier: ViewModifier {
  
  let isOpened: Bool
  let offset: CGFloat
  
  func body(content: Content) -> some View {
    content
      .shadow(color: Color.black.opacity(isOpened ? 0.1 : 0.0), radius: 10, x: 0, y: 5)
      .offset(y: isOpened ? offset : 0)
      .opacity(isOpened ? 100 : 0)
      .animation(.spring(response: 0.1, dampingFraction: 1.0, blendDuration: 0.5), value: isOpened)
  }
}

extension View {
  func displayOnMenuOpen(_ isOpened: Bool, offset: CGFloat) -> some View {
    modifier(DisplayOnOpenMenuViewModifier(isOpened: isOpened, offset: offset))
  }
}

struct CustomMenu_Previews: PreviewProvider {
  static var previews: some View {
    CustomMenu(numberOfCategories: 3)
  }
}
