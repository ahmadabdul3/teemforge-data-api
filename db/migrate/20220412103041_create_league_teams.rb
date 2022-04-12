class CreateLeagueTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :league_teams do |t|
      t.references :team, type: :uuid, foreign_key: true
      t.references :league, type: :uuid, foreign_key: true
      t.integer :points
      t.string :status

      t.timestamps
    end
  end
end
