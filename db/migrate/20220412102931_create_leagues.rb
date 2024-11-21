class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
