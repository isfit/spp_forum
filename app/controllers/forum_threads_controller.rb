class ForumThreadsController < ApplicationController
  respond_to :html
  load_and_authorize_resource 

  def new
    @forum = Forum.find(params[:forum_id])
  end

  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

  def show
    @forum_thread = ForumThread.find(params[:id])
  end

  def create
    #@forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.forum_id = params[:forum_id]
    respond_to do |format|
      if @forum_thread.save
        format.html {redirect_to forum_path(@forum_thread.forum), :notice => "Thread created" }
      else
        format.html {render :action => :new}
      end
    end
  end

  def update
    @forum_thread = ForumThread.find(params[:id])
    status = @forum_thread.update_attributes(params[:forum_thread])

    respond_to do |format|
      if status 
        format.html {redirect_to forum_thread_path(@forum_thread), :notice => "Thread updated!" }
      else
        format.html {render :action => :edit}
      end
    end
  end
end
