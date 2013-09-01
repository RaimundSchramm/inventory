require 'spec_helper'

feature 'Updating games' do
  given!(:game) { Game.create(name: 'Skat') }

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
    expect(page).to have_field('Name', with: 'Skat')

    fill_in 'Name', with: 'Rommie'
    click_on 'Update Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Rommie'
    expect(game.reload.name).to eq 'Rommie'
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
    expect(game.reload.name).to eq 'Rommie'
  end
end
