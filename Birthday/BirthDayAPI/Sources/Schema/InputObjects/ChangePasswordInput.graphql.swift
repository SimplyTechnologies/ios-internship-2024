// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ChangePasswordInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    newPassword: String,
    oldPassword: String
  ) {
    __data = InputDict([
      "newPassword": newPassword,
      "oldPassword": oldPassword
    ])
  }

  public var newPassword: String {
    get { __data["newPassword"] }
    set { __data["newPassword"] = newValue }
  }

  public var oldPassword: String {
    get { __data["oldPassword"] }
    set { __data["oldPassword"] = newValue }
  }
}
