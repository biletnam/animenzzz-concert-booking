class AreasController < ApplicationController

  def index
  	@recital = Recital.find params[:recital_id]
  	@areas = @recital.areas
  end

  def show
  	@recital = Recital.find params[:recital_id]
  	@area = @recital.areas.find(params[:id])
  end
end
