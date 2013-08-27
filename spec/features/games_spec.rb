require 'spec_helper'

describe "Games" do
  describe "GET /games" do
    it 'lists all games in inventory' do
      visit '/games'
      expect(body).to have_content('Listing games')
    end
  end

  describe "GET /" do
    it "shows link to games resource" do
      visit root_path
      expect(body).to have_content('Games')
    end
  end
end
