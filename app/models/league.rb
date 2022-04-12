class League < ApplicationRecord
    # relations
    has_many :league_teams
    has_many :teams, through: :league_teams
end
