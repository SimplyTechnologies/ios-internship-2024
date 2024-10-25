// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetShopsQuery: GraphQLQuery {
  public static let operationName: String = "GetShops"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetShops { shops { __typename id image address id image isFavorite name phone rate url } }"#
    ))

  public init() {}

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("shops", [Shop].self),
    ] }

    public var shops: [Shop] { __data["shops"] }

    /// Shop
    ///
    /// Parent Type: `Shop`
    public struct Shop: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Shop }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("image", String.self),
        .field("address", String.self),
        .field("isFavorite", Bool.self),
        .field("name", String.self),
        .field("phone", String?.self),
        .field("rate", Double?.self),
        .field("url", String?.self),
      ] }

      public var id: Int { __data["id"] }
      public var image: String { __data["image"] }
      public var address: String { __data["address"] }
      public var isFavorite: Bool { __data["isFavorite"] }
      public var name: String { __data["name"] }
      public var phone: String? { __data["phone"] }
      public var rate: Double? { __data["rate"] }
      public var url: String? { __data["url"] }
    }
  }
}
