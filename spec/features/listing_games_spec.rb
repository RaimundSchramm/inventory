require 'spec_helper'

feature 'Listing games' do

  given(:any_date) { Date.today }
  given!(:game) { FactoryGirl.create :game, last_played: any_date }

  scenario 'lists all games in inventory' do
    visit '/games'

    expect(current_path).to eq games_path

    # page header
    expect(page).to have_content 'Listing games'

    # table header
    expect(page).to have_selector 'th', text: 'Name'
    expect(page).to have_selector 'th', text: 'Author'
    expect(page).to have_selector 'th', text: 'Category'
    expect(page).to have_selector 'th', text: 'Location'
    expect(page).to have_selector 'th', text: 'Min players'
    expect(page).to have_selector 'th', text: 'Max players'
    expect(page).to have_selector 'th', text: 'Min playtime'
    expect(page).to have_selector 'th', text: 'Max playtime'
    expect(page).to have_selector 'th', text: 'Rating'
    expect(page).to have_selector 'th', text: 'Times played'
    expect(page).to have_selector 'th', text: 'Last played'

    # table content
    expect(page).to have_content 'Skat'
    expect(page).to have_content 'Author of Skat'
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

  scenario 'each game links to its detail page via its name' do
    visit '/games'
    expect(page).to have_link "#{game.name}", href: "/games/#{game.id}"

    # this expectation exists because the scenario follows a default rails scaffold
    # which had this link
    expect(page).not_to have_link "Show", href: "/games/#{game.id}"
  end
end
