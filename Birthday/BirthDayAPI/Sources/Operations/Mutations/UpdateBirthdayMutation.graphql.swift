// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateBirthdayMutation: GraphQLMutation {
  public static let operationName: String = "UpdateBirthdayMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateBirthdayMutation($id: Int!, $updateBirthdayInput: UpdateBirthdayInput!) { updateBirthday(id: $id, updateBirthdayInput: $updateBirthdayInput) { __typename id date image message name relation } }"#
    ))

  public var id: Int
  public var updateBirthdayInput: UpdateBirthdayInput

  public init(
    id: Int,
    updateBirthdayInput: UpdateBirthdayInput
  ) {
    self.id = id
    self.updateBirthdayInput = updateBirthdayInput
  }

  public var __variables: Variables? { [
    "id": id,
    "updateBirthdayInput": updateBirthdayInput
  ] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateBirthday", UpdateBirthday.self, arguments: [
        "id": .variable("id"),
        "updateBirthdayInput": .variable("updateBirthdayInput")
      ]),
    ] }

    public var updateBirthday: UpdateBirthday { __data["updateBirthday"] }

    /// UpdateBirthday
    ///
    /// Parent Type: `Birthday`
    public struct UpdateBirthday: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Birthday }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("date", BirthDayAPI.DateTime.self),
        .field("image", String?.self),
        .field("message", String?.self),
        .field("name", String.self),
        .field("relation", String.self),
      ] }

      public var id: Int { __data["id"] }
      public var date: BirthDayAPI.DateTime { __data["date"] }
      public var image: String? { __data["image"] }
      public var message: String? { __data["message"] }
      public var name: String { __data["name"] }
      public var relation: String { __data["relation"] }
    }
  }
}
