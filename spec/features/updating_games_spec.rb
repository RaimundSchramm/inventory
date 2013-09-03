require 'spec_helper'

feature 'Updating games' do
  given(:any_date) { Date.today }
  before do 
    @game = Game.create({
    name: 'Skat',
    author: 'Author of Skat',
    category: 'Cardgame',
    location: 'Raimund',
    min_players: 3,
    max_players: 4,
    min_playtime: 1,
    max_playtime: 0,
    rating: 5,
    times_played: 10,
    last_played: any_date
    })
  end

  scenario 'access edit game from games#index page' do
    visit '/games'

    click_on 'Edit'
    expect(current_path).to eq "/games/#{Game.last.id}/edit"
    expect(page).to have_field('Name', with: 'Skat')
  end

  scenario 'submitting the update form updates the game' do
    visit '/games'

    click_on 'Edit'
    expect(current_path).to eq "/games/#{Game.last.id}/edit"
# save_and_open_page
    expect(page).to have_field 'Name', with: 'Skat'
    expect(page).to have_field 'Author', with: 'Author of Skat'
    expect(page).to have_field 'Category', with: 'Cardgame'
    expect(page).to have_field 'Location', with: 'Raimund'
    expect(page).to have_field 'Min players', with: '3'
    expect(page).to have_field 'Max players', with: '4'
    expect(page).to have_field 'Min playtime', with: '1'
    expect(page).to have_field 'Max playtime', with: '0'
    expect(page).to have_field 'Rating', with: '5'
    expect(page).to have_field 'Times played', with: '10'
    expect(page).to have_field 'Last played', with: any_date.to_s

    fill_in 'Name',               with: 'Rommie'
    fill_in 'Author',             with: 'him'
    fill_in 'Category',           with: 'another Cardgame'
    fill_in 'Location',           with: 'Mirko'
    fill_in 'Min players',        with: '4'
    fill_in 'Max players',        with: ''
    fill_in 'Min playtime',       with: '10'
    fill_in 'Max playtime',       with: '120'
    fill_in 'Rating',             with: '3'
    fill_in 'Times played',       with: '5'
    fill_in 'Last played',        with: any_date.next_day

    click_on 'Update Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Game was successfully updated.'
    expect(page).to have_content 'Rommie'
    expect(page).to have_content 'him'
    expect(page).to have_content 'another Cardgame'
    expect(page).to have_content 'Mirko'
    expect(page).to have_content '4'
    expect(page).to have_content ''
    expect(page).to have_content '10'
    expect(page).to have_content '120'
    expect(page).to have_content '3'
    expect(page).to have_content '5'
    expect(page).to have_content any_date.next_day

    @game.reload
  end

  scenario 'submitting the update accessed via show form updates the game' do
    visit '/games'

    click_on 'Show'
    expect(current_path).to eq "/games/#{Game.last.id}"

    click_on 'Edit'
    fill_in 'Name', with: 'Rommie'
    click_on 'Update Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Rommie'
    expect(@game.reload.name).to eq 'Rommie'
  end
end
