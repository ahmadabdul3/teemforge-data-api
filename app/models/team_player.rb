class TeamPlayer < ApplicationRecord
    # relations
    belongs_to :team
    belongs_to :player

    # validations
    validates_uniqueness_of :team_id, :scope => :player_id, :message => 'player already in this team'

    @status = {
        active: 'active',
        inactive: 'inactive',
    }

    @player_status = {
        first_pick: 'first_pick',
        reserve: 'reserve',
        inactive: 'inactive',
    }

    class << self
        attr_reader :status
        attr_reader :player_status
    end

    def self.build_standard(params:)
        TeamPlayer.new({
            status: TeamPlayer.status[:active],
            player_status: TeamPlayer.player_status[:first_pick],
        }.merge(params))
    end

    def self.join_team(player_id:, team_id:)
        build_params = { player_id: player_id, team_id: team_id }
        first_pick_count = TeamPlayer.roster_players(team_id: team_id).count

        if Team.max_players_reached(num_players: first_pick_count)
            build_params[:player_status] = TeamPlayer.player_status[:reserve]
        end

        team_player = TeamPlayer.build_standard params: build_params
        team_player.validate

        if team_player.errors.added? :team_id, :taken, value: team_id
            TeamPlayer
                .where(player_id: player_id, team_id: team_id)
                .update_all(status: TeamPlayer.status[:active])
        else
            team_player.save
        end
    end

    # roster players are those on the team (active) and are first pick
    def self.roster_players(team_id:)
        TeamPlayer.where(
            team_id: team_id,
            status: TeamPlayer.status[:active],
            player_status: TeamPlayer.player_status[:first_pick],
        )
    end

    def leave_team
        update(status: TeamPlayer.status[:inactive])
    end
end
