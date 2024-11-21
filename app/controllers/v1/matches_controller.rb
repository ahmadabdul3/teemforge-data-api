module V1
    class MatchesController < ApplicationController
        def view_all
            render json: { data: Match.all_default }
        rescue
            render json: { data: 'error fetching matches' }
        end

        # invite is when 1 team invites another to a match
        def invite

        rescue

        end

        private

        def valid_params_invite
            params.require(:match).permit(
                # requesting team becomes host (unless defined otherwise)
                # requesting team becomes team_1
                :requesting_team,
                :team_2,
                :match_type,
            )
        end
    end
end
