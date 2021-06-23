class Follower < ApplicationRecord
    belongs_to :user
    validatesvalidates_uniqueness_of :follower_id, scope: :following_id