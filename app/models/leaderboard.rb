class Leaderboard < ApplicationRecord
  validates :nickname, length: {minimum: 3}
  attribute :rank

  scope :ranking, -> { from(Leaderboard.select("*, rank() over(order by wpm desc)"), 'leaderboards').order(wpm: :desc) }
end