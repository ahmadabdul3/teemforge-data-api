class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, id: :uuid do |t|
      t.string :position
      t.boolean :looking_for_team, default: false

      t.timestamps
    end
  end
end
