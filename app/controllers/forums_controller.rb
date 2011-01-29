class ForumsController < ApplicationController
  def index
    if can?(:read, Forum)
      @forums = Forum.all
      @authorized = true
    else
      @forums = []
      @authorized = false
    end
    # authorize! :read, Forum
  end

  def show
    @forum = Forum.find(params[:id]) if can?(:read, Forum)
    authorize! :read, Forum
  end

  def new
    @forum = Forum.new if can?(:create, Forum)
    authorize! :create, Forum
  end

  def create
    @forum = Forum.new(params[:forum])
    respond_to do |format|
      if can?(:create, Forum) and @forum.save
        format.html { redirect_to(forum_path(@forum), :notice=>"Forum was saved successfully") }
        format.js
      else
        flash[:notice] = "Something went wrong"
        format.html { render :action => "new" }
      end
    end
  end
end
