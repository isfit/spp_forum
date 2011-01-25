class ForumPostsController < ApplicationController
  def new
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post = ForumPost.new
#    @forum_post.forum_thread = @forum_thread
  end

  def edit
  end

  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post.forum_thread = @forum_thread
    @forum_post.user = current_user
    @forum_thread.user = current_user

    respond_to do |format|
      if @forum_post.save
        format.html { redirect_to(forum_thread_path(@forum_thread), :notice=>"Forum post was saved successfully") }
        format.js
      else
        flash[:notice] = "Something went wrong"
        format.html { render :action => "new" }
      end
    end
  end

end
