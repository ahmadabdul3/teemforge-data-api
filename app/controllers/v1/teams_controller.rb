module V1
    class TeamsController < ApplicationController
        def view_all
            render json: { data: Team.all }
        end

        def create
            team = Team.new(name: valid_params[:name])

            if team.save
                render json: { data: team }
            else
                render json: { data: 'error saving' }
            end
        end

        def view_by_name
            team_name = params[:name]
            team = Team.find_by(name: team_name)

            if not team.nil?
                render json: { data: team }
            else
                render json: { data: 'no team found with name: ' + team_name }
            end
        end

        def view_all_for_player
            teams = Team.joins(:players).where("players.id = ?", params[:player_id])

            if teams.any?
                render json: { data: teams }
            else
                render json: { data: 'no teams found for player' }
            end
        end

        private

        def valid_params
            params.require(:team).permit(
                :name
            )
        end
    end
end
