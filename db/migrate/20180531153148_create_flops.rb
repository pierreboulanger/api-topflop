class CreateFlops < ActiveRecord::Migration[5.2]
  def change
    create_table :flops do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment
      t.string :flopplayer

      t.timestamps
    end
  end
end
