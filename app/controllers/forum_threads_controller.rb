class ForumThreadsController < ApplicationController
  respond_to :html
  load_and_authorize_resource 

  def new
    @forum = Forum.find(params[:forum_id]) if can?(:create, ForumThread)
  end

  def edit
    @forum_thread = ForumThread.find(params[:id])
    if !(can?(:update, @forum_thread))
      @forum_thread = nil
    end
  end

  def show
    @forum_thread = ForumThread.find(params[:id]) if can?(:read, ForumThread)
  end

  def create
    #@forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.forum_id = params[:forum_id]
    @forum_thread.user = current_user
    respond_to do |format|
      if can?(:create, ForumThread) and @forum_thread.save
        format.html {redirect_to forum_path(@forum_thread.forum), :notice => "Thread created" }
      else
        format.html {render :action => :new}
      end
    end
  end

  def update
    @forum_thread = ForumThread.find(params[:id])

    respond_to do |format|
      if can?(:update, @forum_thread) and @forum_thread.update_attributes(params[:forum_thread]) 
        format.html {redirect_to forum_thread_path(@forum_thread), :notice => "Thread updated!" }
      else
        format.html {render :action => :edit}
      end
    end
  end
end
