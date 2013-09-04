require 'spec_helper'

feature 'Adding games' do

  given(:any_date) { Date.today }

  scenario 'shows a form for adding a new game' do

    visit '/games'
    click_on 'New Game'

    expect(current_path).to eq new_game_path

    expect(page).to have_selector 'form'
    expect(page).to have_field    'Name'
    expect(page).to have_field    'Author'
    expect(page).to have_field    'Category'
    expect(page).to have_field    'Location'
    expect(page).to have_field    'Min players'
    expect(page).to have_field    'Max players'
    expect(page).to have_field    'Min playtime'
    expect(page).to have_field    'Max playtime'
    expect(page).to have_field    'Rating'
    expect(page).to have_field    'Times played'
    expect(page).to have_field    'Last played'
  end

  scenario 'submitting a filled-out form adds a new game' do

    visit '/games/new'

    fill_in 'Name',               with: 'Skat'
    fill_in 'Author',             with: 'me'
    fill_in 'Category',           with: 'Cardgame'
    fill_in 'Location',           with: 'Raimund'
    fill_in 'Min players',        with: '3'
    fill_in 'Max players',        with: '4'
    fill_in 'Min playtime',       with: '1'
    fill_in 'Max playtime',       with: ''
    fill_in 'Rating',             with: '5'
    fill_in 'Times played',       with: '10'
    fill_in 'Last played',        with: any_date

    expect{ click_button 'Create Game' }.to change(Game, :count).from(0).to(1)

    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Game was successfully created.'
    expect(page).to have_content 'Skat'
    expect(page).to have_content 'me'
    expect(page).to have_content 'Cardgame'
    expect(page).to have_content 'Raimund'
    expect(page).to have_content '3'
    expect(page).to have_content '4'
    expect(page).to have_content '1'
    expect(page).to have_content ''
    expect(page).to have_content '5'
    expect(page).to have_content '10'
    expect(page).to have_content any_date
  end

  scenario 'access game detail view after adding a new game' do
    visit '/games'
    click_on 'New Game'
    fill_in 'Name', with: 'Rommie'
    click_on 'Create Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
  end
end
