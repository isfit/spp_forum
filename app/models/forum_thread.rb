class ForumThread < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :forum_posts
end
