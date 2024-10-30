// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ForgotPasswordInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    email: String
  ) {
    __data = InputDict([
      "email": email
    ])
  }

  public var email: String {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }
}
