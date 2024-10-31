// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class ResetPasswordEmailMutation: GraphQLMutation {
  public static let operationName: String = "ResetPasswordEmailMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation ResetPasswordEmailMutation($forgotPasswordInput: ForgotPasswordInput!) { forgotPassword(forgotPasswordInput: $forgotPasswordInput) }"#
    ))

  public var forgotPasswordInput: ForgotPasswordInput

  public init(forgotPasswordInput: ForgotPasswordInput) {
    self.forgotPasswordInput = forgotPasswordInput
  }

  public var __variables: Variables? { ["forgotPasswordInput": forgotPasswordInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("forgotPassword", String.self, arguments: ["forgotPasswordInput": .variable("forgotPasswordInput")]),
    ] }

    public var forgotPassword: String { __data["forgotPassword"] }
  }
}
