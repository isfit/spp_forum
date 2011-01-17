require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Forum.first
    assert_template 'show'
  end
end
