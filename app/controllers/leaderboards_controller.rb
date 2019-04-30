class LeaderboardsController < ApplicationController

  def index
    @leaderboard = Leaderboard.ranking.limit(10)
    render json: {ranking: @leaderboard}
  end

  def create
    @leaderboard = Leaderboard.new(leaderboard_params)
    if @leaderboard.save
      render json: Leaderboard.ranking.find(@leaderboard.id)
    else
      render json: { error: "Could not save score" }
    end
  end

  private

  def leaderboard_params
    params.require(:leaderboard).permit(:nickname, :wpm, :race_text)
  end
end