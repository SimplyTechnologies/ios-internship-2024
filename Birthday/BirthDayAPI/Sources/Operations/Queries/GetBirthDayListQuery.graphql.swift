// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetBirthDayListQuery: GraphQLQuery {
  public static let operationName: String = "GetBirthDayList"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetBirthDayList { birthdays { __typename createdAt date id image message name relation upcomingAge upcomingBirthday updatedAt userId } }"#
    ))

  public init() {}

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("birthdays", [Birthday].self),
    ] }

    public var birthdays: [Birthday] { __data["birthdays"] }

    /// Birthday
    ///
    /// Parent Type: `Birthday`
    public struct Birthday: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Birthday }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("createdAt", BirthDayAPI.DateTime.self),
        .field("date", BirthDayAPI.DateTime.self),
        .field("id", Int.self),
        .field("image", String?.self),
        .field("message", String?.self),
        .field("name", String.self),
        .field("relation", String.self),
        .field("upcomingAge", Int?.self),
        .field("upcomingBirthday", BirthDayAPI.DateTime.self),
        .field("updatedAt", BirthDayAPI.DateTime.self),
        .field("userId", Int.self),
      ] }

      public var createdAt: BirthDayAPI.DateTime { __data["createdAt"] }
      public var date: BirthDayAPI.DateTime { __data["date"] }
      public var id: Int { __data["id"] }
      public var image: String? { __data["image"] }
      public var message: String? { __data["message"] }
      public var name: String { __data["name"] }
      public var relation: String { __data["relation"] }
      public var upcomingAge: Int? { __data["upcomingAge"] }
      public var upcomingBirthday: BirthDayAPI.DateTime { __data["upcomingBirthday"] }
      public var updatedAt: BirthDayAPI.DateTime { __data["updatedAt"] }
      public var userId: Int { __data["userId"] }
    }
  }
}
