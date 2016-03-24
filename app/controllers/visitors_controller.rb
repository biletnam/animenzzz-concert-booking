class VisitorsController < ApplicationController
  def index
  	@recitals = Recital.all.sort_by {|r| r.id }
  	@indexVideo = Video.where(name: 'Unravel (Tokyo Ghoul OP1)')
  	@videos = Video.where.not(name: 'Unravel (Tokyo Ghoul OP1)')
  end
end
