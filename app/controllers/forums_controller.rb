class ForumsController < ApplicationController
  def index
    @forums = Forum.all
  end

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(params[:forum])
    respond_to do |format|
      if @forum.save
        format.html { redirect_to(forum_path(@forum), :notice=>"Forum was saved successfully") }
        format.js
      else
        flash[:notice] = "Something went wrong"
        format.html { render :action => "new" }
      end
    end
  end
end
