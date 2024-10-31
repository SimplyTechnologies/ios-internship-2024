// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ResetPasswordInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    hash: String,
    password: String,
    passwordConfirm: String
  ) {
    __data = InputDict([
      "hash": hash,
      "password": password,
      "passwordConfirm": passwordConfirm
    ])
  }

  public var hash: String {
    get { __data["hash"] }
    set { __data["hash"] = newValue }
  }

  public var password: String {
    get { __data["password"] }
    set { __data["password"] = newValue }
  }

  public var passwordConfirm: String {
    get { __data["passwordConfirm"] }
    set { __data["passwordConfirm"] = newValue }
  }
}
