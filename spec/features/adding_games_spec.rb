require 'spec_helper'

describe 'Adding games' do
  it 'shows a form for adding a new game' do
    visit '/games/new'
    expect(page).to have_selector 'form'

    expect(page).to have_field 'Name'
    expect(page).to have_field 'Author'
    expect(page).to have_field 'Category'
    expect(page).to have_field 'Location'

    expect(page).to have_field 'Min players'
    expect(page).to have_field 'Max players'
    expect(page).to have_field 'Min playtime'
    expect(page).to have_field 'Max playtime'
    expect(page).to have_field 'Rating'
    expect(page).to have_field 'Times played'

    expect(page).to have_field 'Last played'

    click_button 'Create Game'
    expect(current_path).to eq "/games/#{Game.last.id}"
    expect(page).to have_content 'Game was successfully created.'
  end
end
