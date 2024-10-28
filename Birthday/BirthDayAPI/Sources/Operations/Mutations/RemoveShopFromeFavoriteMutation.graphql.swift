// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RemoveShopFromeFavoriteMutation: GraphQLMutation {
  public static let operationName: String = "RemoveShopFromeFavorite"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RemoveShopFromeFavorite($shopId: Int!) { removeShopFromFavorite(shopId: $shopId) { __typename createdAt shopId userId } }"#
    ))

  public var shopId: Int

  public init(shopId: Int) {
    self.shopId = shopId
  }

  public var __variables: Variables? { ["shopId": shopId] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("removeShopFromFavorite", RemoveShopFromFavorite.self, arguments: ["shopId": .variable("shopId")]),
    ] }

    public var removeShopFromFavorite: RemoveShopFromFavorite { __data["removeShopFromFavorite"] }

    /// RemoveShopFromFavorite
    ///
    /// Parent Type: `UserFavoriteShop`
    public struct RemoveShopFromFavorite: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.UserFavoriteShop }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("createdAt", BirthDayAPI.DateTime.self),
        .field("shopId", Int.self),
        .field("userId", Int.self),
      ] }

      public var createdAt: BirthDayAPI.DateTime { __data["createdAt"] }
      public var shopId: Int { __data["shopId"] }
      public var userId: Int { __data["userId"] }
    }
  }
}
