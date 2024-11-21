module V1
    class LeaguesController < ApplicationController
        def view_all
            render json: { data: League.all }
        end
    end
end
