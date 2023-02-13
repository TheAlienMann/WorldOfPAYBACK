//
//  TransactionsModel.swift
//  WorldOfPAYBACK
//
//  Created by Mohamad Rahmani on 01.02.23.
//

import Foundation

// MARK: - Items

struct Transactions: Codable {
  let items: [Item]
}

// MARK: - Item

struct Item: Codable, Identifiable {
  var id = UUID()
  let partnerDisplayName: String
  let alias: Alias
  let category: Categories
  let transactionDetail: TransactionDetail
  
  enum CodingKeys: CodingKey {
    case partnerDisplayName
    case alias
    case category
    case transactionDetail
  }
}

// MARK: - Alias

struct Alias: Codable {
  let reference: String
}

// MARK: - TransactionDetail

struct TransactionDetail: Codable {
  let description: String?
  let bookingDate: Date
  let value: Value
}

// MARK: - Category

enum Categories: Int, Codable, CaseIterable, Identifiable {
  case categoryOne = 1
  case categoryTwo
  case categoryThree
  case categoryFour
  
  var id: String { String(self.rawValue) }
}

// MARK: - Value

struct Value: Codable {
  let amount: Int
//  let currency: Currency
  let currency: String
}

enum Currency: String, Codable {
  case pbp = "PBP"
}
