class AddAttributesToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.string :author, :category, :location
      t.integer :min_players, :max_players, :min_playtime, :max_playtime, :times_played, :rating
      t.date :last_played
    end
  end
end
