//
//  User.swift
//  Company_Task_Releted_To_TableView_And_CollectionView
//
//  Created by Apple on 17/12/22.
//

import Foundation
struct userApiResponse : Decodable{
    var name : Name
}
struct Name : Decodable{
    var firstname : String
    var lastname : String
}
