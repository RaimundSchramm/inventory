require 'spec_helper'

feature 'Showing games' do

  given(:any_date) { Date.today }
  given!(:game) { create :game, last_played: any_date }

  scenario 'lists all attributes of a game' do
    visit "/games/#{game.id}"

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

  scenario 'each game detail page has a link for editing' do
    visit '/games'

    # this expectation exists because the scenario follows a default rails scaffold
    # which had this link
    expect(page).not_to have_link "Edit", href: "/games/#{game.id}/edit"

    click_on "#{game.name}"
    expect(page).to have_link "Edit", href: "/games/#{game.id}/edit"
  end

  scenario 'each game detail page has a link for destroying' do
    visit '/games'

    # this expectation exists because the scenario follows a default rails scaffold
    # which had this link
    expect(page).not_to have_link "Destroy", href: "/games/#{game.id}"

    click_on "#{game.name}"
    expect(page).to have_link "Destroy", href: "/games/#{game.id}"
  end
end
