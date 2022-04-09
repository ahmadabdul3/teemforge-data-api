class Player < ApplicationRecord
    # relations
    # - need this association to do join queries
    has_many :team_players
    has_many :teams, through: :team_players
    has_many :active_team_players,
        -> { where(status: TeamPlayer.status[:active]) },
        class_name: 'TeamPlayer'
    has_many :active_teams,
        through: :active_team_players,
        source: :team

    def self.get_with_teams(player_id)
        Player
            .left_joins(:active_teams)
            .group(:id)
            .select(
                'players.*',
                'json_agg(teams.name) AS team_names'
            )
            .find(player_id)
    end
end
