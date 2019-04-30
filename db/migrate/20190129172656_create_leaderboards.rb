class CreateLeaderboards < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboards do |t|
      t.string "nickname", null: false
      t.integer "wpm", null: false
      t.text "race_text", null: false

      t.timestamps
    end
  end
end
