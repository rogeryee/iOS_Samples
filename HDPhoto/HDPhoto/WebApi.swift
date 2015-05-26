//
//  WebApi.swift
//  HDPhoto
//
//  Created by Roger Yee on 5/26/15.
//  Copyright (c) 2015 Roger Yee. All rights reserved.
//

import UIKit
import Alamofire

enum Router : URLRequestConvertible {
    static let baseURL = "https://api.500px.com/v1"
    static let consumerKey = "j9LaCoiMIW1mcNgEhLpFfE6KrKieijb5QKZM5JiS"
    
    case SinglePhoto(Int, Five100px.ImageSize)
    case PopularPhotos(Int)
    
    var URLRequest : NSURLRequest {
        
        // 计算属性
        let (path:String, parameters:[String:AnyObject]) = {
            
            switch self {
            case .SinglePhoto(let id, let imgSize) :
                let params = [
                    "consumer_key": Router.consumerKey,
                    "image_size":imgSize.rawValue
                ]
                return ("/photos/\(id)", params as! [String : AnyObject])
            case .PopularPhotos(let page):
                let params = [
                    "consumer_key": Router.consumerKey,
                    "page":page
                ]
                return ("/photos", params as! [String : AnyObject])
            }
        }()
        
        let url = NSURL(string: Router.baseURL)?.URLByAppendingPathComponent(path)
        let request = NSURLRequest(URL: url!)
        
        return Alamofire.ParameterEncoding.URL.encode(request, parameters: parameters).0
    }
}

extension Request {
    
    /*
     * 创建了一个Image的Serializer
     */
    public class func ImageResponseSerializer() -> Serializer {
        return { request, response, data in
            if data == nil || data?.length == 0 {
                return (nil, nil)
            }
            
            var serializationError: NSError?
            let image = UIImage(data:data!)
            
            
            return (image, nil)
        }
    }

    public func responseImage(options: NSJSONReadingOptions = .AllowFragments, completionHandler: (NSURLRequest, NSHTTPURLResponse?, UIImage?, NSError?) -> Void) -> Self {
        return response(serializer: Request.ImageResponseSerializer(), completionHandler: { request, response, image, error in
            completionHandler(request, response, image as! UIImage?, error)
        })
    }
}