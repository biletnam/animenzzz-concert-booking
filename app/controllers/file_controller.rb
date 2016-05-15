class FileController < ApplicationController
  def download
  	send_file "/public/files/#{params[:filename]}"
  end
end
