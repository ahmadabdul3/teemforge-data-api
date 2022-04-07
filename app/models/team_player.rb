class TeamPlayer < ApplicationRecord
    # relations
    belongs_to :team
    belongs_to :player

    # validations
    validates_uniqueness_of :team_id, :scope => :player_id, :message => "player already in this team"

    @status = {
        active: 'active',
        inactive: 'inactive',
    }

    class << self
        attr_reader :status
    end

    def self.build_standard(player, team)
        TeamPlayer.new(
            player: player,
            team: team,
            status: TeamPlayer.status[:active]
        )
    end

    def leave_team
        update(status: TeamPlayer.status[:inactive])
    end
end
