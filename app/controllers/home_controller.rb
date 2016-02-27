class HomeController < ApplicationController
  def index
    @homepage = Homepage.new
  end

  def about
  end
end
