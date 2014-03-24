class UserGroupsController < ApplicationController
  before_action :set_user_group, only: [:show, :edit, :update, :destroy, :inviteMember]

  before_filter :authenticate_user!#, :except => [:some_action_without_auth]

  # GET /user_groups
  # GET /user_groups.json
  def index
    @user_groups = UserGroup.includes(user_group_members: :user).all
    @user_group_new = UserGroup.new
  end

  # GET /user_groups/1
  # GET /user_groups/1.json
  def show
  end

  # GET /user_groups/new
  def new
    @user_group = UserGroup.new
  end

  # GET /user_groups/1/edit
  def edit
  end

  # POST /user_groups
  # POST /user_groups.json
  def create
    @user_group = UserGroup.new(user_group_params)
    @user_group.user_id = current_user.id

    respond_to do |format|
      if @user_group.save
        format.html { redirect_to user_groups_path, notice: 'User group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_groups/1
  # PATCH/PUT /user_groups/1.json
  def update
    respond_to do |format|
      if @user_group.update(user_group_params)
        format.html { redirect_to @user_group, notice: 'User group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.json
  def destroy
    @user_group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_url }
      format.json { head :no_content }
    end
  end

  def inviteMember

    @user = User.find_by_email(params[:email])

    if (!@user)
      respond_with_errors("No existe un usuario con ese email", 'error')
      return
    end

    @user_group_member = @user_group.user_group_members.build(:user_id => @user.id)
    @user_group_members = UserGroupMember.where(user_group_id: @user_group.id)
    
    respond_to do |format|
      if @user_group_member.save
        format.html { redirect_to user_group_members_path, notice: 'El usuario ha sido invitado al grupo!' }
        format.json { render 'user_group_members/index', notice: 'El usuario ha sido invitado al grupo!', status: :created }
      else
        format.html { render action: 'new' }
        # format.json { render json: @user_group_member.errors.full_messages, status: :unprocessable_entity }
        format.json { render json: build_json_errors(@user_group_member.errors, 'error'), status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group
      @user_group = UserGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_params
      params.require(:user_group).permit(:name)
    end

    # respond back to the client an http 400 status plus the errors array
    def respond_with_errors(errors, severity)
      respond_to do |format|
        # render :json => {:errors => errors}, :status => :bad_request
        format.html { render notice: errors }
        format.json { render :json => build_json_errors(errors, severity), :status => :bad_request }
      end
    end

    def build_json_errors(errors, severity)
      if (errors.kind_of?(String))
        # if it's just an string, return it as errors
        return { :messages => [
              { :text => errors, :severity => severity }
          ]
        }

      else
        # if not, build the proper json for each array elem
        errors_arr = Array.new
        errors.each do |key, msg|
            errors_arr.push({ :text => "#{msg}", :severity => severity })
        end
        return { :messages => errors_arr }
      end
    end
end
