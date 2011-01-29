module ForumThreadsHelper

  def get_user_post_text(user)
    if user
      text = ""
      text += image_tag user.picture.url(:thumb) + "<br />" if user and user.picture.exists?
      text += "<strong>" + link_to(user.name, user) + "</strong>" if user.name
      text += "<br />Posts: "
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
