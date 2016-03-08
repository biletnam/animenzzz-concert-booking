class VisitorsController < ApplicationController
  def index
  	@recitals = Recital.all
  end
end
