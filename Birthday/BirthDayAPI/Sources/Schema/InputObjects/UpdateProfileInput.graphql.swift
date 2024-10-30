// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UpdateProfileInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    firstName: GraphQLNullable<String> = nil,
    image: GraphQLNullable<String> = nil,
    lastName: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "firstName": firstName,
      "image": image,
      "lastName": lastName
    ])
  }

  public var firstName: GraphQLNullable<String> {
    get { __data["firstName"] }
    set { __data["firstName"] = newValue }
  }

  public var image: GraphQLNullable<String> {
    get { __data["image"] }
    set { __data["image"] = newValue }
  }

  public var lastName: GraphQLNullable<String> {
    get { __data["lastName"] }
    set { __data["lastName"] = newValue }
  }
}
