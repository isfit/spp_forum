class CreateForumPosts < ActiveRecord::Migration
  def self.up
    create_table :forum_posts do |t|
      t.string :title
      t.belongs_to :user
      t.belongs_to :forum_thread
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_posts
  end
end
