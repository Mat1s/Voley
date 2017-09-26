class GamesController < ApplicationController
  before_action :user_logged_in?
  before_action :games_exist, only: [:show, :update, :add_vacancies, :destroy_vacancies]
  def new
    @game = current_user.games.new
    @game.vacancies.new(user_id: current_user.id)
  end

  def create
    @game = current_user.games.new(game_permit_params)
    if @game.save
      @game.vacancies.create(user_id: current_user.id)
      @game.owner(current_user.id)
      redirect_to game_path(@game)
      flash[:info] = "Game #{@game.name} successfully created"
    else
      render new_game_path
      flash.now[:alert] = "Game is failed"
    end
  end
  
  def show
    @game = Game.find(params[:id])
    @comments = Comment.where('pcomment_type = ?', "Game")
    @user = current_user
  end

  def add_vacancies
    @game = Game.find(params[:id])
    if @game 
      if @game.vacancies.count < @game.max_vacancies_for_players && !@game.users.find_by(id: current_user.id)
        @game.vacancies.create(user_id: current_user.id)
        redirect_to @game
      end
    end
  end
  
  def destroy_vacancies
    @game = Game.find(params[:id])
    if @game && vac = @game.vacancies.find_by(user_id: current_user.id)
      vac.delete
      redirect_to @game
    end
  end
  
  def edit
  end
  
  def update
    @game = Game.find(params[:id])

  end

  def destroy
      
    @game = Game.find(params[:id])
    @game.vacancies.delete
    @game.delete
    redirect_to user_path(current_user.id)
  end

  def index
    @last_games = Game.where('time_event >= ?', Time.zone.now.at_end_of_minute)
    @games = Game.where('time_event < ?', Time.zone.now.at_end_of_minute)
  end

  private

  def game_permit_params
    params.require(:game).permit(:name, :level, :max_vacancies_for_players,
                                                :city, :street, :time_event, :user_id)
  end

  def user_logged_in?
    redirect_to login_path unless logged_in?
  end

  def games_exist
    redirect_to root_url if !game = Game.find_by(params[:id])
  end
end
