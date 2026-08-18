class SessionsController < ApplicationController
  def show
    @session = Session.find(params[:id])
  end

  def destroy
    @session = Session.find(params[:id])
    @session.destroy

    redirect_to root_path
    # rediction à changer où ?
  end
end
