class CreateTops < ActiveRecord::Migration[5.2]
  def change
    create_table :tops do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment
      t.string :topplayer

      t.timestamps
    end
  end
end
