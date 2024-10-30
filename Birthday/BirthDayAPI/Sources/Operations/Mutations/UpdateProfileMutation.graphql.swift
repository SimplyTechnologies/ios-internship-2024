// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateProfileMutation: GraphQLMutation {
  public static let operationName: String = "UpdateProfileMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateProfileMutation($updateProfileInput: UpdateProfileInput!) { updateProfile(updateProfileInput: $updateProfileInput) { __typename firstName image lastName } }"#
    ))

  public var updateProfileInput: UpdateProfileInput

  public init(updateProfileInput: UpdateProfileInput) {
    self.updateProfileInput = updateProfileInput
  }

  public var __variables: Variables? { ["updateProfileInput": updateProfileInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateProfile", UpdateProfile.self, arguments: ["updateProfileInput": .variable("updateProfileInput")]),
    ] }

    public var updateProfile: UpdateProfile { __data["updateProfile"] }

    /// UpdateProfile
    ///
    /// Parent Type: `User`
    public struct UpdateProfile: BirthDayAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.User }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("firstName", String.self),
        .field("image", String?.self),
        .field("lastName", String.self),
      ] }

      public var firstName: String { __data["firstName"] }
      public var image: String? { __data["image"] }
      public var lastName: String { __data["lastName"] }
    }
  }
}
