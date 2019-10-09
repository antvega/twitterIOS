//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Antonio Vega Jr on 9/25/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFav = !favorited
        if(toBeFav){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(true)
                
            }, failure: { (error) in
                 print("favorited did not succeed")
            })
        } else {
            TwitterAPICaller.client?.unFavoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(false)
            }, failure: { (error) in
                print("unfavorite did not work")
            })
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("error with retweeting")
        })
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
            retweetButton.setTitle("Retweeted", for: .normal)
            retweetButton.isEnabled = false
        }else{
            retweetButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            retweetButton.setTitle("Retweet", for: .normal)
            retweetButton.isEnabled = true
        }
    }

    func setFavorited(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favoriteButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            favoriteButton.setTitle("Liked", for: .normal)
        }
        else {
            favoriteButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
            favoriteButton.setTitle("Like", for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
