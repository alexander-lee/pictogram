//
//  Post.swift
//  Pictogram
//
//  Created by Alexander on 10/18/16.
//  Copyright © 2016 Alexander. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    var media: PFFile?
    var author: PFUser?
    var caption: String?
    var likeCount: Int?
    var comments: [String]?
    
    init(object: PFObject){
        if let media = object.valueForKey("media") as? PFFile {
            self.media = media;
        }
        
        if let author = object.valueForKey("author") as? PFUser {
            self.author = author;
        }
        
        if let caption = object.valueForKey("caption") as? String {
            self.caption = caption;
        }
        
        if let likeCount = object.valueForKey("likeCount") as? Int {
            self.likeCount = likeCount;
        }
        
        if let comments = object.valueForKey("comments") as? [String] {
            self.comments = comments;
        }
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?){
        let post = PFObject(className: "Post");
        
        post["media"] = getPFFileFromImage(image);
        post["author"] = PFUser.currentUser();
        post["caption"] = caption
        post["likeCount"] = 0
        post["comments"] = [];
        
        post.saveInBackgroundWithBlock(completion);
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image){
                return PFFile(name: "image.png", data: imageData);
            }
        }
        return nil;
    }
    
    class func getUserImages(pageCount: Int?, successCallback: ([Post]) -> Void, error: ((NSError?) -> Void)?) {
        let query = PFQuery(className: "Post");
        query.orderByDescending("createdAt");
        query.includeKey("author");
        query.limit = 20 * (pageCount ?? 1);
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, errorVal: NSError?) -> Void in
            if let posts = posts {
                let postObjs = posts.map({ (post: PFObject) -> Post in
                    return Post(object: post);
                });
                
                successCallback(postObjs);
            } else {
                if let error = error {
                    error(errorVal);
                }
            }
        }
    }

}
