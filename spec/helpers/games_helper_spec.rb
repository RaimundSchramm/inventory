require 'spec_helper'

describe GamesHelper do
  # clearify code organisation between controller, helper, view, spec etc.
  # clearify how to use private controller helper methods in spec
  describe 'sortable' do
    xit 'returns a link for sending a request with sort params' do
      expect(helper.sortable 'name').to eq link_to "Name"
    end
  end
end
