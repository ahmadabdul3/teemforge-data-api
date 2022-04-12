class League < ApplicationRecord
    # relations
    has_many :league_teams
    has_many :leagues, through: :league_teams
end
