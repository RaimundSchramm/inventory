require 'spec_helper'

feature 'Showing games' do
  background do
    @any_date = Time.now
    game = Game.create({
      name: 'Skat',
      author: 'Author of Skat',
      category: 'Cardgame',
      location: 'Raimund',
      min_players: 3,
      max_players: 4,
      min_playtime: 1,
      max_playtime: nil,
      rating: 5,
      times_played: 100,
      last_played: @any_date
    })
  end

  scenario 'lists all attributes of a game' do
    visit "/games/#{Game.last.id}"

    expect(page).to have_content 'Skat'
    expect(page).to have_content 'Author of Skat'
    expect(page).to have_content 'Cardgame'
    expect(page).to have_content 'Raimund'
    expect(page).to have_content '3'
    expect(page).to have_content '4'
    expect(page).to have_content '1'
    expect(page).to have_content ''
    expect(page).to have_content '5'
    expect(page).to have_content '100'
    expect(page).to have_content '2013-09-01'
  end

  scenario 'access game detail view from games#index page' do
    visit '/games'

    # page header
    expect(page).to have_content 'Listing games'

    # table content
    expect(page).to have_link 'Show'
    click_on 'Show'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Skat'
  end

  scenario 'access game detail view after adding a new game' do
    visit '/games'

    click_on 'New Game'
    fill_in 'Name', with: 'Rommie'
    click_on 'Create Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Rommie'
  end

  scenario 'access game detail view after adding a new game' do
    visit '/games'

    click_on 'Edit'
    fill_in 'Name', with: 'Rommie'
    click_on 'Update Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Rommie'
  end
end
