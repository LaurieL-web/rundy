class PagesController < ApplicationController
  def home
    @objective = Objective.new
  end
  
end
