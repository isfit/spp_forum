class ForumPostsController < ApplicationController
  def new
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    @forum_post = ForumPost.new
  end

  def edit
    @forum_post = ForumPost.find(params[:id])
    @forum_thread = @forum_post.forum_thread
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

  def update
    @forum_post = ForumPost.find(params[:id])

    respond_to do |format|
      if @forum_post.update_attributes(params[:forum_post])
        format.html {redirect_to forum_thread_path(@forum_post.forum_thread), :notice => "Post updated!" }
      else
        format.html {render :action => :edit}
      end
    end
  end

end
