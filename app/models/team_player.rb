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
        player_status = TeamPlayer.player_status[:first_pick]
        create_params = { player_id: player_id, team_id: team_id }
        roster_count = TeamPlayer.roster_players(team_id: team_id).count

        if Team.max_players_reached(num_players: roster_count)
            player_status = TeamPlayer.player_status[:reserve]
            create_params[:player_status] = player_status
        end

        team_player = TeamPlayer.create! create_params
        TFLogger.log message: 'new player joined team'
    rescue ActiveRecord::RecordInvalid => e
        TFLogger.log message: 'error joining team'

        unless e.record.errors.added? :team_id, :taken, value: team_id
            TFLogger.log message: e.record.errors.details
            raise e
        end

        TFLogger.log message: 'player already associated with team, updating status'
        # when a player reactivates (rejoins) a team, we need to make sure their
        # player_status is updated correctly. if the team has less than the max
        # first_pick players when they rejoin, they should be set as first_pick
        TeamPlayer
            .where(player_id: player_id, team_id: team_id)
            .update_all(status: TeamPlayer.status[:active], player_status: player_status)
    end

    def leave_team
        update(status: TeamPlayer.status[:inactive])
    end

    # roster players are those on the team (active) and are first pick
    def self.roster_players(team_id:)
        TeamPlayer.where(
            team_id: team_id,
            status: TeamPlayer.status[:active],
            player_status: TeamPlayer.player_status[:first_pick],
        )
    end

    # if a player used to be on the team, but left (so the record exists but the
    # status is inactive), and is joining back, we update their status
    # back to active
    # this also applies to players who are actively on the team
    def already_associated_with_team
        validate
        errors.added? :team_id, :taken, value: team_id
    end
end
