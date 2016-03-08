class AreasController < ApplicationController

  # def index
  # 	@areas = Recital.find(params[:recital_id]).areas
  # end

  def show
  	@area = Recital.find(params[:recital_id]).areas.find(params[:id])
  end
end
