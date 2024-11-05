// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class RateShopMutation: GraphQLMutation {
  public static let operationName: String = "RateShopMutation"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation RateShopMutation($rateShopInput: RateShopInput!) { rateShop(rateShopInput: $rateShopInput) }"#
    ))

  public var rateShopInput: RateShopInput

  public init(rateShopInput: RateShopInput) {
    self.rateShopInput = rateShopInput
  }

  public var __variables: Variables? { ["rateShopInput": rateShopInput] }

  public struct Data: BirthDayAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { BirthDayAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("rateShop", Bool.self, arguments: ["rateShopInput": .variable("rateShopInput")]),
    ] }

    public var rateShop: Bool { __data["rateShop"] }
  }
}
