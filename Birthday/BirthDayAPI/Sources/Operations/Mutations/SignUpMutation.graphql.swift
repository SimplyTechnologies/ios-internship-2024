// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SignUpMutation: GraphQLMutation {
  public static let operationName: String = "SignUp"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SignUp($signUpInput: SignUpInput!) { signUp(signUpInput: $signUpInput) { __typename id email firstName lastName image } }"#
    ))

  public var signUpInput: SignUpInput

  public init(signUpInput: SignUpInput) {
    self.signUpInput = signUpInput
  }

  public var __variables: Variables? { ["signUpInput": signUpInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("signUp", SignUp.self, arguments: ["signUpInput": .variable("signUpInput")]),
    ] }

    public var signUp: SignUp { __data["signUp"] }

    /// SignUp
    ///
    /// Parent Type: `User`
    public struct SignUp: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", Int.self),
        .field("email", String.self),
        .field("firstName", String.self),
        .field("lastName", String.self),
        .field("image", String?.self),
      ] }

      public var id: Int { __data["id"] }
      public var email: String { __data["email"] }
      public var firstName: String { __data["firstName"] }
      public var lastName: String { __data["lastName"] }
      public var image: String? { __data["image"] }
    }
  }
}
