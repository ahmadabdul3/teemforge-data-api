class CreateTeamPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_players do |t|
      t.references :team, type: :uuid, foreign_key: true
      t.references :player, type: :uuid, foreign_key: true

      t.integer :num_goals, :default => 0
      t.string :status, :default => 'inactive'

      t.timestamps
    end

    add_index :team_players, [:team_id, :player_id], unique: true
  end
end
