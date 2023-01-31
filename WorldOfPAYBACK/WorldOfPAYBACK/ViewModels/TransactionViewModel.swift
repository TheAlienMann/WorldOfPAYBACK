//
//  TransactionViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import Foundation
import Combine

final class ItemsViewModel: ObservableObject {
  @Published var items: [Item] = []
  lazy var numberOfCategories: Int = {
    Categories.allCases.count
  }()
  @Published var sortedTransactions: [Item] = []
  private var subscriptions = Set<AnyCancellable>()
  @Published var filterredTransactions: [Item] = []
  
  init() {
//      NetworkServince().loadTransactions(url: "https://some-fake-url.com")
      NetworkServince().loadTransactions(url: "https://api.payback.com/transactions")
      .receive(on: DispatchQueue.main)
      .sink { completion in
      switch completion {
        case let .failure(error):
          print(#line, #file.components(separatedBy: "/").last!, error)
        case .finished:
          print(#line, #file.components(separatedBy: "/").last!, "finished")
      }
    } receiveValue: { [weak self] in
      print(#line, #file.components(separatedBy: "/").last!, "updaing...")
      self?.items = $0.items
      self?.filterredTransactions = $0.items
    }
    .store(in: &subscriptions)
  }
  
  func sortTransactions() -> [Item] {
    items.sorted {
      $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
    }
  }
  
  func filterTransaction(by: Int) -> [Item] {
    return items.filter {
      $0.category.rawValue == by
    }
  }
  
  func sumOfFilterredTransactions(category: Categories) -> Int {
    switch category {
      case .categoryOne, .categoryTwo, .categoryThree:
        return filterTransaction(by: category.rawValue).map(\.transactionDetail.value.amount).reduce(0, +)
    }
  }
  
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.locale = Locale.autoupdatingCurrent
    formatter.calendar = Calendar.autoupdatingCurrent
    formatter.timeZone = TimeZone.autoupdatingCurrent
    return formatter
  }()
}

extension Date {
  func toString(withFormat format: String = "EEEE ، d MMMM yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.autoupdatingCurrent
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.calendar = Calendar.autoupdatingCurrent
    dateFormatter.dateFormat = format
    let str = dateFormatter.string(from: self)
    
    return str
  }
}
