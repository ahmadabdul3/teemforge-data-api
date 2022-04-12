class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches, id: :uuid do |t|
        t.references :team_1, type: :uuid, index: true, foreign_key: { to_table: :teams }
        t.references :team_2, type: :uuid, index: true, foreign_key: { to_table: :teams }
        t.references :host_team, type: :uuid, index: true, null: true, foreign_key: { to_table: :teams }
        t.references :league, type: :uuid, null: true, foreign_key: true

        t.string :match_type, default: 'friendly'
        t.string :match_stage, default: 'qualifying'
        t.string :status, default: 'scheduled'

        t.integer :team_1_goals
        t.integer :team_2_goals

        t.datetime :match_dt
      t.timestamps
    end
  end
end
