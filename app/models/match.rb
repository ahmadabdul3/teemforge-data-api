class Match < ApplicationRecord
    # relations
    belongs_to :team_1, class_name: 'Team', foreign_key: :team_1_id
    belongs_to :team_2, class_name: 'Team', foreign_key: :team_2_id
    belongs_to :host_team, class_name: 'Team', foreign_key: :host_team_id, optional: true
    belongs_to :requesting_team, class_name: 'Team', foreign_key: :requesting_team_id, optional: true
    belongs_to :league, optional: true

    # validations

    # ensure if there's an invitation from either direction, we dont allow the new record
    # still have to test this
    validates_uniqueness_of :requesting_team_id, scope: :team_2_id, message: 'There is already a pending match request between these two teams'
    validates_uniqueness_of :team_2_id, scope: :requesting_team_id, message: 'There is already a pending match request between these two teams'

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
        requested: 'requested',
        declined: 'declined',
        scheduled: 'scheduled',
        in_progress: 'in_progress',
        completed: 'completed',
    }

    class << self
        attr_reader :match_type
        attr_reader :match_stage
        attr_reader :status
    end

    # default means by date ascending
    def self.all_default
        order('match_dt ASC')
    end
end
