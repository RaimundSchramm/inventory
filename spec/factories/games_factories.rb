FactoryGirl.define do

  factory :game do
    name          'Skat'
    author        'Author of Skat'
    category      'Cardgame'
    location      'Raimund'
    min_players   3
    max_players   4
    min_playtime  60
    max_playtime  120
    rating        5
    times_played  10
    last_played   '2013-09-01'
  end

end