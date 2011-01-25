module ForumThreadsHelper

  def get_user_posts_text(user)
    if user
      return user.posts.length
    else
      return "-"
    end
  end

end
