// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateBirthdayMutation: GraphQLMutation {
  public static let operationName: String = "CreateBirthdayMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateBirthdayMutation($createBirthdayInput: CreateBirthdayInput!) { createBirthday(createBirthdayInput: $createBirthdayInput) { __typename id date name relation message image } }"#
    ))

  public var createBirthdayInput: CreateBirthdayInput

  public init(createBirthdayInput: CreateBirthdayInput) {
    self.createBirthdayInput = createBirthdayInput
  }

  public var __variables: Variables? { ["createBirthdayInput": createBirthdayInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createBirthday", CreateBirthday.self, arguments: ["createBirthdayInput": .variable("createBirthdayInput")]),
    ] }

    public var createBirthday: CreateBirthday { __data["createBirthday"] }

    /// CreateBirthday
    ///
    /// Parent Type: `Birthday`
    public struct CreateBirthday: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Birthday }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("date", BirthDayAPI.DateTime.self),
        .field("name", String.self),
        .field("relation", String.self),
        .field("message", String?.self),
        .field("image", String?.self),
      ] }

      public var id: Int { __data["id"] }
      public var date: BirthDayAPI.DateTime { __data["date"] }
      public var name: String { __data["name"] }
      public var relation: String { __data["relation"] }
      public var message: String? { __data["message"] }
      public var image: String? { __data["image"] }
    }
  }
}
