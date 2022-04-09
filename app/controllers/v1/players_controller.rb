module V1
    class PlayersController < ApplicationController
        def view_all
            render json: { data: Player.all }
        end

        def create
            player = Player.new(position: valid_params[:position])

            if player.save
                render json: { data: player }
            else
                render json: { data: 'error saving player' }
            end
        end

        def join_team
            if TeamPlayer.join_team(params[:player_id], params[:team_id])
                render json: { data: Player.get_with_teams(params[:player_id]) }
            else
                render json: { data: 'error saving' }
            end
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
                :position
            )
        end
    end
end
