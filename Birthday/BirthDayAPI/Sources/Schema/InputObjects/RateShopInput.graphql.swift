// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct RateShopInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    rating: Int,
    shopId: Int
  ) {
    __data = InputDict([
      "rating": rating,
      "shopId": shopId
    ])
  }

  public var rating: Int {
    get { __data["rating"] }
    set { __data["rating"] = newValue }
  }

  public var shopId: Int {
    get { __data["shopId"] }
    set { __data["shopId"] = newValue }
  }
}
