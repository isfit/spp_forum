module ForumThreadsHelper

  def get_user_post_text(user)
    if user
      text = ""
      text += user.name if user.name
      if user.forum_posts and (user.forum_posts).length > 0
        text += (user.forum_posts.length).to_s
      else
        text += "0"
      end
      return text
    else
      return "-"
    end
  end

end
