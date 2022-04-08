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

    class << self
        attr_reader :status
    end

    def self.build_standard(player_id, team_id)
        TeamPlayer.new(
            player_id: player_id,
            team_id: team_id,
            status: TeamPlayer.status[:active]
        )
    end

    def self.join_team(player_id, team_id)
        team_player = TeamPlayer.build_standard player_id, team_id
        team_player.validate

        if team_player.errors.added? :team_id, :taken, value: team_id
            TeamPlayer
                .where(player_id: player_id, team_id: team_id)
                .update(status: TeamPlayer.status[:active])
        else
            team_player.save
        end
    end

    def leave_team
        update(status: TeamPlayer.status[:inactive])
    end
end
