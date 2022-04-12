Rails.application.routes.draw do
    namespace :v1 do
        get 'repositories', to: 'repositories#index'

        # leagues
        get '/leagues', to: 'leagues#view_all'

        # teams
        get '/teams', to: 'teams#view_all'
        get '/teams/:name', to: 'teams#view_by_name'
        get '/teams/all-for-player/:player_id', to: 'teams#view_all_for_player'
        post '/teams', to: 'teams#create'
        patch '/teams/:id', to: 'teams#update'

        # players
        get '/players', to: 'players#view_all'
        get '/players/free-agents', to: 'players#view_free_agents'
        post '/players', to: 'players#create'
        patch '/players/:id', to: 'players#update'
        patch '/players/:player_id/join-team/:team_id', to: 'players#join_team'
        patch '/players/:player_id/leave-team/:team_id', to: 'players#leave_team'
    end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ('/')
    # root 'articles#index'
end


# fetch('http://localhost:3000/v1/teams', {
#     method: 'POST',
#     headers: {
#         'Content-Type': 'application/json',
#     },
#     body: JSON.stringify({ name: 'foo' }),
# }).then(r => r.json()).then(r => {
#     console.log('r, ', r);
# });

# fetch('http://localhost:3000/v1/players', {
#     method: 'POST',
#     headers: {
#         'Content-Type': 'application/json',
#     },
#     body: JSON.stringify({ position: 'striker' }),
# }).then(r => r.json()).then(r => {
#     console.log('r, ', r);
# });

# fetch('http://localhost:3000/v1/players/4beea166-5836-43f6-93de-0d69e85b2bd3/join-team/8b81674c-f678-4a0f-bac5-85e461f2531a', {
#     method: 'PATCH',
#     headers: {
#         'Content-Type': 'application/json',
#     },
#     body: JSON.stringify({}),
# }).then(r => r.json()).then(r => {
#     console.log('r, ', r);
# });
