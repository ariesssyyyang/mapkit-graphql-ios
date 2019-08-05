//  This file was automatically generated and should not be edited.

import Apollo

public final class NearbyQuery: GraphQLQuery {
  public let operationDefinition =
    "query Nearby($latitude: Float!, $longitude: Float!) {\n  search(latitude: $latitude, longitude: $longitude) {\n    __typename\n    business {\n      __typename\n      name\n      id\n      alias\n      rating\n      url\n      location {\n        __typename\n        address1\n      }\n    }\n  }\n}"

  public var latitude: Double
  public var longitude: Double

  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }

  public var variables: GraphQLMap? {
    return ["latitude": latitude, "longitude": longitude]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["latitude": GraphQLVariable("latitude"), "longitude": GraphQLVariable("longitude")], type: .object(Search.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.flatMap { (value: Search) -> ResultMap in value.resultMap }])
    }

    /// Search for businesses on Yelp.
    public var search: Search? {
      get {
        return (resultMap["search"] as? ResultMap).flatMap { Search(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["Businesses"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("business", type: .list(.object(Business.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(business: [Business?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Businesses", "business": business.flatMap { (value: [Business?]) -> [ResultMap?] in value.map { (value: Business?) -> ResultMap? in value.flatMap { (value: Business) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of business Yelp finds based on the search criteria.
      public var business: [Business?]? {
        get {
          return (resultMap["business"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Business?] in value.map { (value: ResultMap?) -> Business? in value.flatMap { (value: ResultMap) -> Business in Business(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Business?]) -> [ResultMap?] in value.map { (value: Business?) -> ResultMap? in value.flatMap { (value: Business) -> ResultMap in value.resultMap } } }, forKey: "business")
        }
      }

      public struct Business: GraphQLSelectionSet {
        public static let possibleTypes = ["Business"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(String.self)),
          GraphQLField("alias", type: .scalar(String.self)),
          GraphQLField("rating", type: .scalar(Double.self)),
          GraphQLField("url", type: .scalar(String.self)),
          GraphQLField("location", type: .object(Location.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil, id: String? = nil, alias: String? = nil, rating: Double? = nil, url: String? = nil, location: Location? = nil) {
          self.init(unsafeResultMap: ["__typename": "Business", "name": name, "id": id, "alias": alias, "rating": rating, "url": url, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Name of this business.
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// Yelp ID of this business.
        public var id: String? {
          get {
            return resultMap["id"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// Yelp alias of this business.
        public var alias: String? {
          get {
            return resultMap["alias"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "alias")
          }
        }

        /// Rating for this business (value ranges from 1, 1.5, ... 4.5, 5).
        public var rating: Double? {
          get {
            return resultMap["rating"] as? Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "rating")
          }
        }

        /// URL for business page on Yelp.
        public var url: String? {
          get {
            return resultMap["url"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }

        /// The location of this business, including address, city, state, postal code and country.
        public var location: Location? {
          get {
            return (resultMap["location"] as? ResultMap).flatMap { Location(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "location")
          }
        }

        public struct Location: GraphQLSelectionSet {
          public static let possibleTypes = ["Location"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("address1", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(address1: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Location", "address1": address1])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Street address of this business.
          public var address1: String? {
            get {
              return resultMap["address1"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "address1")
            }
          }
        }
      }
    }
  }
}