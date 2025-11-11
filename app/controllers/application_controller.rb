class ApplicationController < ActionController::API
  MAX_PAGINATION_LIMIT = 100
  rescue_from ActiveRecord::RecordNotFound, with: :notFound

  private

  def limit
    [ params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i, MAX_PAGINATION_LIMIT ].min
  end

  def notFound(e)
    render json: { errors: e }, status: :not_found
  end
end
