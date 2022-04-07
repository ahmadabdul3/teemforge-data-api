class Player < ApplicationRecord
    # relations
    # - need this association to do join queries
    has_many :team_players
    has_many :teams, through: :team_players

end
