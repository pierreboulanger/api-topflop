class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :team, foreign_key: true
      t.string :opponent_name
      t.string :date
      t.string :score
      t.string :top
      t.string :flop
      t.string :status

      t.timestamps
    end
  end
end
