// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct SignUpInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    email: String,
    firstName: String,
    lastName: String,
    password: String
  ) {
    __data = InputDict([
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "password": password
    ])
  }

  public var email: String {
    get { __data["email"] }
    set { __data["email"] = newValue }
  }

  public var firstName: String {
    get { __data["firstName"] }
    set { __data["firstName"] = newValue }
  }

  public var lastName: String {
    get { __data["lastName"] }
    set { __data["lastName"] = newValue }
  }

  public var password: String {
    get { __data["password"] }
    set { __data["password"] = newValue }
  }
}
