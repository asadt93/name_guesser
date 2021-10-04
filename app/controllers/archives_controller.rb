class ArchivesController < ApplicationController
  def index
    result = Archive.all
    
    render json: {
      count: result.count,
    }, status: :ok
  end
end