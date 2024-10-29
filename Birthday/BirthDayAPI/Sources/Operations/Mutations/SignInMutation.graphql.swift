// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignInMutation: GraphQLMutation {
  public static let operationName: String = "SignIn"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignIn($loginInput: LoginInput!) { login(loginInput: $loginInput) { __typename accessToken } }"#
    ))

  public var loginInput: LoginInput

  public init(loginInput: LoginInput) {
    self.loginInput = loginInput
  }

  public var __variables: Variables? { ["loginInput": loginInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("login", Login.self, arguments: ["loginInput": .variable("loginInput")]),
    ] }

    public var login: Login { __data["login"] }

    /// Login
    ///
    /// Parent Type: `AccessToken`
    public struct Login: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.AccessToken }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("accessToken", String.self),
      ] }

      public var accessToken: String { __data["accessToken"] }
    }
  }
}
