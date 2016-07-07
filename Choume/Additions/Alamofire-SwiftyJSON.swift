//
//  AlamofireSwiftyJSON.swift
//  AlamofireSwiftyJSON
//
//  Created by Pinglin Tang on 14-9-22.
//  Copyright (c) 2014 SwiftyJSON. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON
import ObjectMapper

// MARK: - Request for Swift JSON

extension Request {
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
    
    :returns: The request.
    */
//        public func responseSwiftyJSON(completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, NSError?) -> Void) -> Self {
//            return responseSwiftyJSON(nil, options:NSJSONReadingOptions.AllowFragments, completionHandler:completionHandler)
//        }
    
    /**
    Adds a handler to be called once the request has finished.
    
    :param: queue The queue on which the completion handler is dispatched.
    :param: options The JSON serialization reading options. `.AllowFragments` by default.
    :param: completionHandler A closure to be executed once the request has finished. The closure takes 4 arguments: the URL request, the URL response, if one was received, the SwiftyJSON enum, if one could be created from the URL response and data, and any error produced while creating the SwiftyJSON enum.
    
    :returns: The request.
    */
    public func responseSwiftyJSON(queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, NSError?) -> Void) -> Self {
        
        return response(queue: queue, responseSerializer: Request.JSONResponseSerializer(options: options), completionHandler: { (request, response, result) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                var responseJSON: JSON
                if result.isFailure
                {
                    responseJSON = JSON.null
                } else {
                    responseJSON = SwiftyJSON.JSON(result.value!)
                }
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(self.request!, self.response, responseJSON, result.error as? NSError)
                })
            })
        })
    }
}

extension JSON {
    
    ///需要json本身是CfUser
    func toCfUser() -> CfUser?{
        var cfUser: CfUser?
        do{
            cfUser = try Mapper<CfUser>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return cfUser
    }
    
    func toCfProject() -> CfProject?{
        var cfProject: CfProject?
        do{
            cfProject = try Mapper<CfProject>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return cfProject
    }
    
    func toUserWallet() -> UserWallet?{
        var wallet: UserWallet?
        do{
            wallet = try Mapper<UserWallet>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return wallet
    }
    
    func toUserWalletHistory() -> UserWalletHistory?{
        var userWalletHistory: UserWalletHistory?
        do{
            userWalletHistory = try Mapper<UserWalletHistory>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return userWalletHistory
    }
    
    func toUserAddress() -> UserAddress?{
        var userAddress: UserAddress?
        do{
            userAddress = try Mapper<UserAddress>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return userAddress
    }
    
    func toCfProjectComment() -> CfProjectComment?{
        var comment: CfProjectComment?
        do{
            comment = try Mapper<CfProjectComment>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return comment
    }
    
    func toCfProjectInvest() -> CfProjectInvest?{
        var invest: CfProjectInvest?
        do{
            invest = try Mapper<CfProjectInvest>().map(self.rawString())
        }
        catch let error as NSError {
            print(error)
        }
        return invest
    }
    
    
    func toCfProjects() -> [CfProject]{
        var projects: [CfProject] = []
        if let tmp = Mapper<CfProject>().mapArray(self.rawString()) {
            projects = tmp
        }
//        do{
//            projects = try Mapper<CfProject>().mapArray(self.rawString())!
//        }
//        catch let error as NSError {
//            print(error)
//        }
        return projects
    }
    
    func toCfProjectComments() -> [CfProjectComment]{
        var comments: [CfProjectComment] = []
        if let tmp = Mapper<CfProjectComment>().mapArray(self.rawString()) {
            comments = tmp
        }
        //        do{
        //            projects = try Mapper<CfProject>().mapArray(self.rawString())!
        //        }
        //        catch let error as NSError {
        //            print(error)
        //        }
        return comments
    }
    
    //--------------- parse cm json -----------------------------------
    
    /// return self[APIClient.cfUser]
    func cfUserJSON() -> JSON{
        return self[APIClient.cfUser]
    }
    
    func getToken() -> String{
        return self[APIClient.TOKEN].stringValue
    }
    

    
    
    
    
    /// json.resp.code
    // if json not contain a "resp" return the other model
    func respStatus() -> APIStatus{
        let code = self[APIClient.RESP][APIClient.CODE].intValue
        if let status = APIStatus(rawValue: code){
            return status
        }else{
            return codeStatus()
        }
    }
    
    ///json.code
    func codeStatus() -> APIStatus{
        let code = self[APIClient.CODE].intValue
        return APIStatus(rawValue: code)!
    }
    
    ///json.resp.msg
    func respMsg() -> String {
        let msg = self[APIClient.RESP][APIClient.MSG].stringValue
        return msg
    }
    
    ///json.msg
    func msg() -> String {
        let msg = self[APIClient.MSG].stringValue
        return msg
    }
    
}

