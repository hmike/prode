class UserGroupMembersController < ApplicationController
  before_action :set_user_group_member, only: [:show, :edit, :update, :destroy]

  # GET /user_group_members
  # GET /user_group_members.json
  def index
    @user_group_members = UserGroupMember.all
  end

  # GET /user_group_members/1
  # GET /user_group_members/1.json
  def show
  end

  # GET /user_group_members/new
  def new
    @user_group_member = UserGroupMember.new
  end

  # GET /user_group_members/1/edit
  def edit
  end

  # POST /user_group_members
  # POST /user_group_members.json
  def create
    @user_group_member = UserGroupMember.new(user_group_member_params)

    respond_to do |format|
      if @user_group_member.save
        format.html { redirect_to @user_group_member, notice: 'User group member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_group_member }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_group_members/1
  # PATCH/PUT /user_group_members/1.json
  def update
    respond_to do |format|
      if @user_group_member.update(user_group_member_params)
        format.html { redirect_to @user_group_member, notice: 'User group member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_group_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_group_members/1
  # DELETE /user_group_members/1.json
  def destroy
    @user_group_member.destroy
    respond_to do |format|
      format.html { redirect_to user_group_members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_group_member
      @user_group_member = UserGroupMember.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_group_member_params
      params.require(:user_group_member).permit(:user_group_id, :user_id, :status)
    end
end