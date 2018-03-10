//
//  Channel.swift
//  Smack
//
//  Created by Maike Warner on 1/29/18.
//  Copyright © 2018 Maike. All rights reserved.
//
// other thing what we have to do is we have to make our model mirror exactly what we see in the JSON response. So 'these' names have to be the same (postman) and in the same order. Because it's in the Json, it has to be also here in our model.

//      public private(set) var _id: String!
//      public private(set) var name: String!
//      public private(set) var description: String!
//      public private(set) var __v: Int?

//  The drawbacks for him is that you have to have everything in the model and you have to have the naming convention the same as the JSON return - but it is super nice.
// Just one line of code instead of parse through different properties, but still in the end he prefers the old way, because he can ignore somethings in the model. Gives more control how the model looks like - and not forced to everything what JSON is using.

import Foundation

struct Channel : Decodable {
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
}

