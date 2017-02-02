class HomeController < ApplicationController
  def coming_soon
    render 'coming_soon', layout: 'coming_soon'
  end
end
