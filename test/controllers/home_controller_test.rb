require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'routing' do
    assert_recognizes({ controller: 'home', action: 'index' }, '/')
    assert_generates('/', { controller: 'home', action: 'index' })
    assert_routing({ path: '/', method: :get }, { controller: 'home', action: 'index' })
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
