class Game < ActiveRecord::Base

  # derived attributes
  def min_to_max_players
    "#{self.min_players}-#{self.max_players}"
  end

  def min_to_max_playtime
    "#{self.min_playtime}-#{self.max_playtime}"
  end
end
