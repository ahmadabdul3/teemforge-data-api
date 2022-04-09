class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.boolean :recruiting, default: false

      t.timestamps
    end
  end
end
