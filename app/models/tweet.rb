class Tweet < ApplicationRecord
    
    paginates_per 50
    validates :content, presence:true
    #validates :retweet_id, uniqueness: { scope: :user_id }

    
    has_many :likes, dependent: :destroy
    
    belongs_to :user
    #has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_id', dependent: :destroy;
    

   
  
end
