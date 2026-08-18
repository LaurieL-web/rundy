class SeancesController < ApplicationController
  def show
    @seance = Seance.find(params[:id])
  end

  def destroy
    @seance = Seance.find(params[:id])
    @seance.destroy

    redirect_to root_path
    # rediction à changer où ?
  end
end
