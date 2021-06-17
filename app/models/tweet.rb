class Tweet < ApplicationRecord
    belongs_to :user
    paginates_per 50
    validates :content, presence:true
    has_many :likes, dependent: :destroy

   
end
