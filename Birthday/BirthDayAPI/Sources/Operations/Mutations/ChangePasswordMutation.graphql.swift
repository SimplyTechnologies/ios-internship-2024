// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ChangePasswordMutation: GraphQLMutation {
  public static let operationName: String = "ChangePassword"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ChangePassword($changePasswordInput: ChangePasswordInput!) { changePassword(changePasswordInput: $changePasswordInput) }"#
    ))

  public var changePasswordInput: ChangePasswordInput

  public init(changePasswordInput: ChangePasswordInput) {
    self.changePasswordInput = changePasswordInput
  }

  public var __variables: Variables? { ["changePasswordInput": changePasswordInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("changePassword", Bool.self, arguments: ["changePasswordInput": .variable("changePasswordInput")]),
    ] }

    public var changePassword: Bool { __data["changePassword"] }
  }
}
