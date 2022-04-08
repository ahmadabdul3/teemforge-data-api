class Team < ApplicationRecord
    # relations
    has_many :team_players
    has_many :players, through: :team_players

    # validations
    validates :name, uniqueness: true

    @max_players = 6

    class << self
        attr_reader :max_players
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
