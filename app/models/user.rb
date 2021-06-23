class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :tweets, dependent: :destroy
has_many :likes, dependent: :destroy

has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  inverse_of: :follower,
                                  dependent: :destroy
has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   inverse_of: :followed,
                                   dependent: :destroy
has_many :following, through: :active_relationships,  source: :followed
has_many :followers, through: :passive_relationships, source: :follower
def follow(other_user)
  following << other_user unless self == other_user
end

def following?(other_user)
  following.include?(other_user)
end

def unfollow(other_user)
  following.delete(other_user)
end

def remember
  self.remember_token = self.class.new_token
  update_attribute(:remember_digest, self.class.digest(remember_token))
end


def forget
  update_attribute(:remember_digest, nil)
end




end
