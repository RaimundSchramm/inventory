require 'spec_helper'

describe Game do
  it 'returns formatted min and max player' do
    game = build :game, min_players: 2, max_players: 4
    expect(game.min_to_max_players).to eq '2-4'
  end

  it 'returns formatted min and max playtime' do
    game = build :game, min_playtime: 60, max_playtime: 120
    expect(game.min_to_max_playtime).to eq '60-120'
  end
end
