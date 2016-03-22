class VisitorsController < ApplicationController
  def index
  	@recitals = Recital.all.sort_by {|r| r.id }
  end
end
