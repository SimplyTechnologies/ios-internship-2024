// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetProfileQuery: GraphQLQuery {
  public static let operationName: String = "GetProfile"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetProfile { profile { __typename email firstName id image lastName } }"#
    ))

  public init() {}

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("profile", Profile.self),
    ] }

    public var profile: Profile { __data["profile"] }

    /// Profile
    ///
    /// Parent Type: `User`
    public struct Profile: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("email", String.self),
        .field("firstName", String.self),
        .field("id", Int.self),
        .field("image", String?.self),
        .field("lastName", String.self),
      ] }

      public var email: String { __data["email"] }
      public var firstName: String { __data["firstName"] }
      public var id: Int { __data["id"] }
      public var image: String? { __data["image"] }
      public var lastName: String { __data["lastName"] }
    }
  }
}
