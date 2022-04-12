# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

leagues = League.create([
    { name: 'champions league' },
]);

teams = Team.create([
    { name: 'team 1' },
    { name: 'team 2' },
    { name: 'team-3' },
]);

leagueTeams = LeagueTeam.create([
    { team: teams[0], league: leagues[0], status: LeagueTeam.status[:active] },
    { team: teams[1], league: leagues[0], status: LeagueTeam.status[:active] },
]);

players = Player.create([
    { position: Player.position[:attack] },
    { position: Player.position[:midfield] },
    { position: Player.position[:defense] },
    { position: Player.position[:attack] },
]);

TeamPlayer.create([
    { team: teams[0], player: players[0] },
    { team: teams[0], player: players[1] },
    { team: teams[1], player: players[2] },
    { team: teams[2], player: players[3] },
]);

matches = Match.create([
    {
        team_1: teams[0],
        team_2: teams[1],
        host_team: teams[0],
        league: leagues[0],
        match_type: Match.match_type[:league],
        match_stage: Match.match_stage[:qualifying],
        status: Match.status[:scheduled],
        match_dt: 1.week.from_now.beginning_of_day + 14.hours, # 2pm
    },
    {
        team_1: teams[0],
        team_2: teams[1],
        host_team: teams[1],
        league: leagues[0],
        match_type: Match.match_type[:league],
        match_stage: Match.match_stage[:first_round],
        status: Match.status[:scheduled],
        match_dt: 2.week.from_now.beginning_of_day + 14.hours, # 2pm
    },
    {
        # demonstrating a non-league match (aka, friendly or otherwise)
        team_1: teams[0],
        team_2: teams[2],
        host_team: teams[2],
        league: nil,
        match_type: Match.match_type[:friendly],
        match_stage: nil,
        status: Match.status[:scheduled],
        match_dt: 1.week.from_now.beginning_of_day + 10.hours, # 10am
    },
]);
