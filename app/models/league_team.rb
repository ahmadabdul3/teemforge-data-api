class LeagueTeam < ApplicationRecord
    # relations
    belongs_to :team
    belongs_to :league

    @status = {
        active: 'active',
        relegated: 'relegated',
    }

    class << self
        attr_reader :status
    end
end
