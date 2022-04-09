module V1
    class TeamsController < ApplicationController
        def view_all
            render json: { data: Team.all }
        end

        # creating a team should automatically make the player (who created the team)
        # join the team
        def create
            team = Team.new(valid_params)

            if team.save
                render json: { data: team }
            elsif team.errors.added? :name, :taken, value: valid_params[:name]
                render json: { data: 'team name already taken' }
            else
                render json: { data: 'error saving' }
            end
        end

        def update
            updated = Team.update(params[:id], valid_params)
            puts updated.errors.details

            if !updated.errors.any?
                render json: { data: updated }
            elsif updated.errors.added? :name, :taken, value: valid_params[:name]
                render json: { data: 'team name already taken' }
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
                :name,
                :recruiting,
            )
        end
    end
end
