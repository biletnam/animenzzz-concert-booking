class RecitalsController < ApplicationController
  before_action :authenticate_user!

  def index
  	@recitals = Recital.all
  end

  def show
  	@recital = Recital.find params[:id]
  end
end
