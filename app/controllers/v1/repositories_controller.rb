module V1
    class RepositoriesController < ApplicationController
        def index
            render json: { data: Team.all }
        end
    end
end
