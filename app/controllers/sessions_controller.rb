class SessionsController < ApplicationController
  def show
    @session = Session.find(params[:id])
  end
end
