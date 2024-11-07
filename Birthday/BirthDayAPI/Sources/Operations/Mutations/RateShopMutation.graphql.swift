// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RateShopMutation: GraphQLMutation {
  public static let operationName: String = "rateShop"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation rateShop($rateShopInput: RateShopInput!) { rateShop(rateShopInput: $rateShopInput) { __typename id rating shopCurrentRating shopId userId } }"#
    ))

  public var rateShopInput: RateShopInput

  public init(rateShopInput: RateShopInput) {
    self.rateShopInput = rateShopInput
  }

  public var __variables: Variables? { ["rateShopInput": rateShopInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("rateShop", RateShop.self, arguments: ["rateShopInput": .variable("rateShopInput")]),
    ] }

    public var rateShop: RateShop { __data["rateShop"] }

    /// RateShop
    ///
    /// Parent Type: `Rating`
    public struct RateShop: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Rating }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("rating", Int.self),
        .field("shopCurrentRating", Double.self),
        .field("shopId", Int.self),
        .field("userId", Int.self),
      ] }

      public var id: Int { __data["id"] }
      public var rating: Int { __data["rating"] }
      public var shopCurrentRating: Double { __data["shopCurrentRating"] }
      public var shopId: Int { __data["shopId"] }
      public var userId: Int { __data["userId"] }
    }
  }
}
