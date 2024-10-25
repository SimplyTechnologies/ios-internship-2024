// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteBirthDayMutation: GraphQLMutation {
  public static let operationName: String = "DeleteBirthDayMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteBirthDayMutation($id: Int!) { deleteBirthday(id: $id) { __typename id } }"#
    ))

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteBirthday", DeleteBirthday.self, arguments: ["id": .variable("id")]),
    ] }

    public var deleteBirthday: DeleteBirthday { __data["deleteBirthday"] }

    /// DeleteBirthday
    ///
    /// Parent Type: `Birthday`
    public struct DeleteBirthday: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Birthday }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
      ] }

      public var id: Int { __data["id"] }
    }
  }
}
