class RecitalsController < ApplicationController

  def show
  	@recital = Recital.find params[:id]
  end
end
