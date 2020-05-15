//
//  Book.swift
//  BookList
//
//  Created by 田露 on 15/5/20.
//  Copyright © 2020 LuTian. All rights reserved.
//

import Foundation
class Book {
    var name:String
    var author:String
    var type:String
    var pages:Int
    var inFinished:Bool
    var summary:String
    var image:String
    var rating:String
    
    init(name:String,author:String,type:String,pages:Int,inFinished:Bool,summary:String,image:String,rating:String=""){
        self.name = name
        self.author = author
        self.image = image
        self.inFinished = inFinished
        self.summary = summary
        self.type = type
        self.pages = pages
        self.rating = rating
    }
    
    convenience init(){
        self.init(name:"",author:"",type:"",pages:0,inFinished:false,summary:"",image:"",rating:"")
    }
    
}
