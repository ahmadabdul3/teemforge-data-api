class Match < ApplicationRecord
    # relations
    belongs_to :team_1, class_name: 'Team', foreign_key: :team_1_id
    belongs_to :team_2, class_name: 'Team', foreign_key: :team_2_id
    belongs_to :host_team, class_name: 'Team', foreign_key: :host_team_id
    belongs_to :league, optional: true

    @match_type = {
        friendly: 'friendly',
        league: 'league',
        practice: 'practice',
    }

    @match_stage = {
        qualifying: 'qualifying',
        first_round: 'first_round',
        quarter_finals: 'quarter_finals',
        final_round: 'final_round',
    }

    @status = {
        scheduled: 'scheduled',
        in_progress: 'in_progress',
        completed: 'completed',
    }

    class << self
        attr_reader :match_type
        attr_reader :match_stage
        attr_reader :status
    end
end
