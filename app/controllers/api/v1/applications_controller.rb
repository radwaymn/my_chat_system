require "securerandom"

class Api::V1::ApplicationsController < ApplicationController
  def index
    applications = Application.limit(limit).offset(params[:page])
    render json: applications
  end

  def create
    application = Application.new(applicationParams)
    token = "#{SecureRandom.uuid}-#{Time.current.to_i}"
    application.token = token

    if application.save
      render json: application, status: :created
    else
      render json: application.errors, status: :unprocessable_entity
    end
  end

  def update
    application = Application.find_by!(token: params[:token])
      if application.update(applicationParams)
        render json: application, status: :ok
      else
        render json: application.errors, status: :unprocessable_entity
      end
  end

  private

  def applicationParams
    params.require(:application).permit(:name)
  end
end
