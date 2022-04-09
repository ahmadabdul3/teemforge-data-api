module V1
    class PlayersController < ApplicationController
        def view_all
            render json: { data: Player.all }
        end

        def view_free_agents
            render json: { data: Player.where(looking_for_team: true) }
        end

        def create
            player = Player.create!(valid_params)
            render json: { data: player }
        rescue
            render json: { data: 'error saving' }
        end

        def update
            updated = Player.update!(params[:id], valid_params)
            render json: { data: updated }
        rescue
            render json: { data: 'error saving' }
        end

        def join_team
            TeamPlayer.join_team(player_id: params[:player_id], team_id: params[:team_id])
            render json: { data: Player.get_with_teams(params[:player_id]) }
        rescue StandardError => e
            TFLogger.log title: 'error', message: e
            render json: { data: 'error saving', error: e }
        end

        def leave_team
            team_player = TeamPlayer.find_by(
                player_id: params[:player_id],
                team_id: params[:team_id]
            )

            if team_player.nil?
                render json: { data: 'this player doesnt play for this team' }
            elsif team_player.leave_team
                render json: { data: 'success' }
            else
                render json: { data: 'error saving' }
            end
        end

        private

        def valid_params
            params.require(:player).permit(
                :position,
                :looking_for_team,
            )
        end
    end
end
