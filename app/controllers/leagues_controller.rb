class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!#, :except => [:some_action_without_auth]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.includes(:teams)
    Rails.logger.debug "********************************************************"
    @leagues.each do |league|
      Rails.logger.debug league.inspect
      Rails.logger.debug league.teams.inspect
    end
    Rails.logger.debug "********************************************************" 
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @leagues_teams = LeaguesTeams.find_all_by_league_id(@league.id, :order => :group_number)
    @league_groups = Hash.new
    @leagues_teams.each do |league_team|
      if (!@league_groups[league_team.group_number]) 
        @league_groups[league_team.group_number] = Array.new
      end
      @league_groups[league_team.group_number].push(league_team)
    end


    @matches = Match.where(:league_id => @league.id, :is_playoff => false).order(:league_date)

    # remove this hack !!! and use the proper group
    group_id = 40

    user_group_member = UserGroupMember.joins(:user_group)
                                                          .where( :user_id => current_user.id, 
                                                                  :user_group_id => group_id,
                                                                  :user_groups => { :league_id => @league.id }
                                                                ).first
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

    @matches = Match.where(:league_id => @league.id, :is_playoff => true).order(:league_date)

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

    @playoff_labels = Hash.new
    @playoff_labels[1] = 'Octavos'
    @playoff_labels[2] = 'Cuartos'
    @playoff_labels[3] = 'Semifinal'
    @playoff_labels[4] = '3er y 4to Puesto'
    @playoff_labels[5] = 'Final'
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render action: 'show', status: :created, location: @league }
      else
        format.html { render action: 'new' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:name, :type, :groups_count, :teams_count)
    end
end
