class Team < ApplicationRecord
    # relations
    has_many :team_players
    has_many :players, through: :team_players

    has_many :league_teams
    has_many :leagues, through: :league_teams

    # validations
    validates :name, uniqueness: true

    def self.max_players
        6
    end

    def self.max_players_reached(num_players:)
        num_players >= Team.max_players
    end

    # scope returns all if there's no result (nil)
    # if you want .first (or nil), use a class method instead
    # scope :get_by_name, lambda { |name|
    #     where(name: name).limit(1).first
    # }
end
