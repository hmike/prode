class UserGroupsController < ApplicationController
	before_action :set_user_group, only: [:show, :edit, :update, :destroy, :invite_user, :fixture, :bet_match, :my_bets, :matches, :reject_invitation, :accept_invitation]

	before_filter :authenticate_user!#, :except => [:some_action_without_auth]

	# GET /user_groups
	# GET /user_groups.json
	def index
		@user_groups = UserGroup.joins(:user_group_members).where("user_group_members.user_id" => current_user.id).all
		@user_group_new = UserGroup.new
		@leagues = League.all
	end

	# GET /user_groups/1
	# GET /user_groups/1.json
	def show
		# scores calculation
		#@todo: hmike: use :score field from db
		@members_scored = @user_group.user_group_members.where(status: 40).sort_by(&:score).reverse!
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
				@user_group.user_group_members.build(:user_id => current_user.id, status: 40).save
	
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

	def invite_user

		if (current_user.email == params[:email])
			respond_with_errors("No podes invitarte a vos mismo")
			return
		end

		user = User.find_by_email(params[:email])

		if (user)
			# check if the User already are in the group
			@user_group_member = UserGroupMember.where(user_id: user.id , user_group_id: @user_group.id).first

			if (@user_group_member)
				if (@user_group_member.status == 10)
					respond_with_errors("Ya invitaste a este usuario, espera su respuesta")
					return
				elseif (@user_group_member.status == 40)
					respond_with_errors("El usuario ya esta jugando en este grupo")
					return
				end
			end
		else
			# send invitation to new User
			user = User.invite!(:email => params[:email], :name => current_user.email)
		end

		if (!@user_group_member)
			@user_group_member = @user_group.user_group_members.build(:user_id => user.id)
		end

		@user_group_member.status = 10
		# @user_group_members = UserGroupMember.where(user_group_id: @user_group.id)
		
		respond_to do |format|
			if @user_group_member.save
				format.html { redirect_to user_group_members_path, notice: 'El usuario ha sido invitado al grupo!' }
				format.json { render json: build_json_messages('Se invito al usuario al grupo!', 'success'), status: :created }
				# format.json { render 'user_group_members/index', notice: 'El usuario ha sido invitado al grupo!', status: :created }
			else
				format.html { render action: 'new' }
				# format.json { render json: @user_group_member.errors.full_messages, status: :unprocessable_entity }
				format.json { render json: build_json_messages(@user_group_member.errors, 'error'), status: :unprocessable_entity }
			end
		end

		# respond_with_success("Se le envio una invitacion por mail!")
		# return
	end

	def accept_invitation
		user_group_member = UserGroupMember.where(user_id: current_user.id, user_group_id: @user_group.id, status: 10).first
		if (!user_group_member)
			respond_with_errors('Invitacion invalida')
			return
		end

		user_group_member.accept()
		respond_with_success('Te has unido al grupo!')
	end
	
	def reject_invitation
		user_group_member = UserGroupMember.where(user_id: current_user.id, user_group_id: @user_group.id, status: 10).first
		if (!user_group_member)
			respond_with_errors('Invitacion invalida')
			return
		end

		user_group_member.reject()
		respond_with_success('Has rechazado la invitacion')
	end

	def my_groups
		@user_group_members = current_user.user_group_members.where(status: 40)
	end
	
	# GET /user_groups/1/fixture
	# GET /user_groups/1/fixture.json
	def fixture

		# definitions for method compatibility
		@league = @user_group.league
		group_id = @user_group.id

		# @leagues_teams = LeaguesTeams.find_all_by_league_id(@league.id, :order => :group_number)
		@leagues_teams = LeaguesTeams.where(:league => @league).order(:group_number)
		@league_groups = Hash.new
		@leagues_teams.each do |league_team|
			if (!league_team.group_number.nil?) 
				if (!@league_groups[league_team.group_number])
					@league_groups[league_team.group_number] = Array.new
				end
				@league_groups[league_team.group_number].push(league_team)
			end
		end


		@matches = Match.where(:league_id => @league.id, :is_playoff => false).order(:league_date => :asc, :date => :asc)

		# user_group_member = UserGroupMember.joins(:user_group)
		#                                                       .where( :user_id => current_user.id, 
		#                                                               :user_group_id => group_id,
		#                                                               :user_groups => { :league_id => @league.id }
		#                                                             ).first

		user_group_member = @user_group.user_group_members.where(:user_id => current_user.id).first

		# get user bets for group matches
		@user_bets = Hash.new
		@matches.each do |match|
			@user_bets[match.id] = match.bets.where(:match_id => match.id, :user_group_member_id => user_group_member.id).first
		end

		@groups_matches = Hash.new
		@matches.each do |match|
			if (!@groups_matches[match.league_date]) 
				@groups_matches[match.league_date] = Array.new
			end
			@groups_matches[match.league_date].push(match)
		end

		@matches = Match.where(:league_id => @league.id, :is_playoff => true).order(:league_date => :asc, :date => :asc)

		# get user bets for playoff matches
		@matches.each do |match|
			@user_bets[match.id] = match.bets.where(:match_id => match.id, :user_group_member_id => user_group_member.id).first
		end

		@playoff_matches = Hash.new
		@matches.each do |match|
			if (!@playoff_matches[match.league_date]) 
				@playoff_matches[match.league_date] = Array.new
			end
			@playoff_matches[match.league_date].push(match)
		end


		# @todo: hmike: calculate labels based on playoff matches count
		@playoff_labels = Hash.new
		@playoff_labels[4] = 'Octavos'
		@playoff_labels[5] = 'Cuartos'
		@playoff_labels[6] = 'Semifinal'
		@playoff_labels[7] = '3er y 4to Puesto'
		@playoff_labels[8] = 'Final'

	end

	def matches
		@matches = @user_group.league.matches.where(:league_date => params[:league_date]).order(:league_date, :date)
	end

	def bet_match
		#@todo: hmike: validate if the bet was expired
		user_group_member = @user_group.user_group_members.where(:user_id => current_user.id).first
		bet = Bet.where(:user_group_member => user_group_member, :match_id => params[:match_id]).first
		if (bet.nil?)
			bet = Bet.new(:user_group_member => user_group_member, :match_id => params[:match_id])
		end

		if bet.update_attributes(:bet => params[:bet])
			respond_with_success("Apuesta realizada!")
		else
			respond_with_errors("No se pudo realizar la apuesta")
		end
	end

	def my_bets
		user_group_member = @user_group.user_group_members.where(:user_id => current_user.id).first
		@my_bets = Bet.where(:user_group_member => user_group_member)
		@matches = Match.where(:league_id => @user_group.league_id).order(:league_date)
		#sort best by match id
		@bets = Hash.new
		@matches.each do |match|
			@bets[match.id] = match.bets.where(:user_group_member_id => user_group_member.id).first
		end

		respond_to do |format|
			format.html { redirect_to user_group_members_path, notice: 'El usuario ha sido invitado al grupo!' }
			format.json { render 'user_groups/my_bets', notice: 'El usuario ha sido invitado al grupo!', status: :created }
		end
	end

	def notifications
		@notifications = current_user.user_group_members.where(status: 10)
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_user_group
			@user_group = UserGroup.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def user_group_params
			params.require(:user_group).permit(:name, :league_id)
		end

		# respond back to the client an http 200 status plus the message
		def respond_with_success(messages)
			respond_with_messages(messages, 'success', :ok)
			# respond_to do |format|
			#   # render :json => {:errors => errors}, :status => :bad_request
			#   format.html { render notice: message }
			#   format.json { render :json => build_json_errors(message, severity), :status => :ok }
			# end
		end

		# respond back to the client an http 400 status plus the errors array
		def respond_with_errors(errors)
			respond_with_messages(errors, 'error', :bad_request)
			# respond_to do |format|
			#   # render :json => {:errors => errors}, :status => :bad_request
			#   format.html { render notice: errors }
			#   format.json { render :json => build_json_errors(errors, severity), :status => :bad_request }
			# end
		end

		def respond_with_messages(messages, severity, status)
			respond_to do |format|
				format.html { render notice: errors }
				format.json { render :json => build_json_messages(messages, severity), :status => status }
			end
		end

		def build_json_messages(errors, severity)
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
