class UsersController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
  load_and_authorize_resource :only => [:show,:new,:destroy,:edit,:update]

  # GET /users
  # GET /users.xml                                                
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    if can?(:read, User)
      @users = User.accessible_by(current_ability, :index)
    else
      @users = []
    end
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end

  # GET /users/new
  # GET /users/new.xml                                            
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
    @user = User.new if can?(:create, User)
    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end
  end

  # GET /users/1
  # GET /users/1.xml                                                       
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
    if can?(:read, User)
      @user = User.find(params[:id])
      @roles = ""

      @user.roles.each do |role|
        if @roles == ""
          @roles += role.name
        else
          @roles += ", " + role.name
        end
      end
    end

    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html      
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # GET /users/1/edit                                                      
  # GET /users/1/edit.xml                                                      
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    @user = User.find(params[:id])
    if can?(:update, @user)
      @roles = ""

      @user.roles.each do |role|
        if @roles == ""
          @roles += role.name
        else
          @roles += ", " + role.name
        end
      end
    else
      @user = nil
    end

    respond_to do |format|
      format.json { render :json => @user }   
      format.xml  { render :xml => @user }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # DELETE /users/1     
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @user.destroy! if can?(:destroy, User)

    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { respond_to_destroy(:html) }      
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # POST /users
  # POST /users.xml         
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    if can?(:create, User)
      @user = User.new(params[:user])
      password_unencrypted = params[:user][:password]
      role = Role.new
      role.name = "normal"
      role.save
      @user.roles.push(role)
    end

    if can?(:create, User) and @user.save
      respond_to do |format|
        ForumMailer.welcome_email(@user, password_unencrypted).deliver
        format.json { render :json => @user.to_json, :status => 200, :text => "User was created!" }
        format.xml  { head :ok }
        format.html { redirect_to :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user.", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  # PUT /users/1.json
  
  def update
    @user = User.find(params[:id])

    # If you can manage users: Always provide your own password to verify changes 
    # Else: Provide the user's password
    valid_password = false
    if (can?(:manage, User))
      valid_current_password = current_user.valid_password?(params[:user][:current_password])
    else
      valid_current_password = @user.valid_password?(params[:user][:current_password])
    end

    @user.errors[:base] << "The password you entered is incorrect" unless valid_current_password
    if params[:user][:password].blank?
      [:password,:password_confirmation,:current_password].collect {|p| params[:user].delete(p)}  
    end

    respond_to do |format|
      if can?(:update, User) and @user.errors[:base].empty? && @user.update_attributes(params[:user])
        flash[:notice] = "Your account has been updated"
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to(@user) }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
  end

  # Get roles accessible by the current user
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability, :read)
  end

  # Make the current user object available to views
  def get_user
    @current_user = current_user
  end

end
