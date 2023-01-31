//
//  NetworkServince.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import Foundation
import Combine

protocol NetworkServinceProtocol {
  func loadTransactions(url: String) -> AnyPublisher<Transactions, Error>
}

enum PaybackError: Error, LocalizedError {
  case failedRequest(description: String)
  case unknown
  
  var errorDescription: String? {
    switch self {
      
      case let .failedRequest(description):
        return description
      case .unknown:
        return "Some unknown error occured."
    }
  }
}

class NetworkServince: NetworkServinceProtocol {
  private var session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func loadTransactions(url: String) -> AnyPublisher<Transactions, Error> {
    guard let url = URL(string: url) else {
      return Fail(error: PaybackError.failedRequest(description: "Bad url, please check the url and try and try again."))
        .eraseToAnyPublisher()
    }
    let request = URLRequest(url: url)
    let dataTask = session.dataTaskPublisher(for: request)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return dataTask
      .tryMap { data, _ in
        return data
      }
      .replaceError(with: try! Data(contentsOf: Bundle.main.url(forResource: "PBTransactions", withExtension: "json")!))
      .decode(type: Transactions.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
