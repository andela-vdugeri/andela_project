ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require_relative "../../config/environment"
require 'minitest/autorun'
require 'rack/test'
require 'rspec'

class MyAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server
  end

  def test_root
    get '/'
    assert_equal 200, last_response.status
  end


  def test_user_login

  end

  def test_product_create

  end

  def test_category_create

  end

  def test_view_product

  end

  def test_view_products

  end

  def test_user_logout

  end
end