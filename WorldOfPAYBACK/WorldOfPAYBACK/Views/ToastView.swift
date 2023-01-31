//
//  ToastView.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import SwiftUI

struct ToastView: View {
  var type: ToastStyle
  var title: String
  var message: String
  var maxWidth: CGFloat = .infinity
  var onCancelTapped: (() -> Void)
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        Image(systemName: type.iconFileName)
          .foregroundColor(type.themeColor)
        
        VStack(alignment: .leading) {
          Text(title)
            .font(.system(size: 14, weight: .semibold))
          Text(message)
            .font(.system(size: 12))
            .foregroundColor(Color.black.opacity(0.6))
        }
        Spacer(minLength: 10)
        
        Button {
          onCancelTapped()
        } label: {
          Image(systemName: "xmark.square")
            .foregroundColor(Color.black)
        }
      }
      .padding()
    }
    .background(Color.white)
    .overlay(
      Rectangle()
        .fill(type.themeColor)
        .frame(width: 6)
        .clipped()
      , alignment: .leading
    )
    .frame(minWidth: 0, maxWidth: maxWidth)
    .cornerRadius(8)
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
    .padding(.horizontal, 16)
  }
}

struct ToastView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading) {
      ToastView(type: .error,
                title: "Error",
                message: "Some Error message") {}
      
      ToastView(type: .info,
                title: "Info",
                message: "Some Info message") {}
      
      ToastView(type: .info,
                title: "Info",
                message: "Some Info message", maxWidth: 200) {}
    }
  }
}

enum ToastStyle {
  case error
  case warning
  case success
  case info
}

extension ToastStyle {
  var themeColor: Color {
    switch self {
      case .error: return Color.red
      case .warning: return Color.orange
      case .info: return Color.blue
      case .success: return Color.green
    }
  }
  
  var iconFileName: String {
    switch self {
      case .info: return "info.circle.fill"
      case .warning: return "exclamationmark.triangle.fill"
      case .success: return "checkmark.circle.fill"
      case .error: return "xmark.circle.fill"
    }
  }
}

struct ToastModel: Equatable {
  var type: ToastStyle
  var title: String
  var message: String
  var duration: Double = 5
}

struct ToastModifier: ViewModifier {
  @Binding var toast: ToastModel?
  @State private var workItem: DispatchWorkItem?
  var transition: Edge = .bottom
  
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(
        ZStack {
          mainToastView()
        }.animation(.spring(), value: toast)
      )
      .onChange(of: toast) { value in
        showToast()
      }
  }
  
  @ViewBuilder func mainToastView() -> some View {
    if let toast = toast {
      VStack {
        if transition == .bottom {
          Spacer()
        }
        ToastView(type: toast.type,
                  title: toast.title,
                  message: toast.message) {
          dismissToast()
        }
        if transition == .top {
          Spacer()
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .transition(AnyTransition.move(edge: transition).combined(with: AnyTransition.opacity))
    }
  }
  
  private func showToast() {
    guard let toast = toast else { return }
    UIImpactFeedbackGenerator(style: .light).impactOccurred()
    if toast.duration > 0 {
      workItem?.cancel()
      let task = DispatchWorkItem {
        dismissToast()
      }
      workItem = task
      DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
    }
  }
  
  private func dismissToast() {
    withAnimation {
      toast = nil
    }
    
    workItem?.cancel()
    workItem = nil
  }
}

extension View {
  func toastView(toast: Binding<ToastModel?>, edge: Edge) -> some View {
    self.modifier(ToastModifier(toast: toast, transition: edge))
  }
}
