class FantasyTeamsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def new
  end

  def create
    @fantasy_team = current_user.fantasy_teams.build(fantasy_team_params)
    if @fantasy_team.save
      flash[:success] = "Fantasy Team created!"
      redirect_to root_url
    else
      @feed_items = []    	
      render 'static_pages/home'
    end
  end

  def destroy
    @fantasy_team.destroy
    redirect_to root_url
  end


  private
    def correct_user
      @fantasy_team = current_user.fantasy_teams.find_by(id: params[:id])
      redirect_to root_url if @fantasy_team.nil?
    end
    def fantasy_team_params
      params.require(:fantasy_team).permit(:tname)
    end  

end
