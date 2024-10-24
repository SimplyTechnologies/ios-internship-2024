// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct UpdateBirthdayInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    date: GraphQLNullable<DateTime> = nil,
    image: GraphQLNullable<String> = nil,
    message: GraphQLNullable<String> = nil,
    name: GraphQLNullable<String> = nil,
    relation: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "date": date,
      "image": image,
      "message": message,
      "name": name,
      "relation": relation
    ])
  }

  public var date: GraphQLNullable<DateTime> {
    get { __data["date"] }
    set { __data["date"] = newValue }
  }

  public var image: GraphQLNullable<String> {
    get { __data["image"] }
    set { __data["image"] = newValue }
  }

  public var message: GraphQLNullable<String> {
    get { __data["message"] }
    set { __data["message"] = newValue }
  }

  public var name: GraphQLNullable<String> {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var relation: GraphQLNullable<String> {
    get { __data["relation"] }
    set { __data["relation"] = newValue }
  }
}
