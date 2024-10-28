// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateBirthdayInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    date: DateTime,
    image: GraphQLNullable<String> = nil,
    message: GraphQLNullable<String> = nil,
    name: String,
    relation: String
  ) {
    __data = InputDict([
      "date": date,
      "image": image,
      "message": message,
      "name": name,
      "relation": relation
    ])
  }

  public var date: DateTime {
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

  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var relation: String {
    get { __data["relation"] }
    set { __data["relation"] = newValue }
  }
}
