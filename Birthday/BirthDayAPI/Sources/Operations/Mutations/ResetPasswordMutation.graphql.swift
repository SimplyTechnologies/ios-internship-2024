// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ResetPasswordMutation: GraphQLMutation {
  public static let operationName: String = "ResetPasswordMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ResetPasswordMutation($resetPasswordInput: ResetPasswordInput!) { resetPassword(resetPasswordInput: $resetPasswordInput) }"#
    ))

  public var resetPasswordInput: ResetPasswordInput

  public init(resetPasswordInput: ResetPasswordInput) {
    self.resetPasswordInput = resetPasswordInput
  }

  public var __variables: Variables? { ["resetPasswordInput": resetPasswordInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("resetPassword", Bool.self, arguments: ["resetPasswordInput": .variable("resetPasswordInput")]),
    ] }

    public var resetPassword: Bool { __data["resetPassword"] }
  }
}
