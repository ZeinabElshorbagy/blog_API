class UsersController < ApplicationController
  include Rails.application.routes.url_helpers
  before_action :authenticate_user!

  def update_photo
    current_user.photo = photo_params[:photo]
    current_user.save!
    render json: current_user, status: :ok
  end

  def user_photo
    if current_user.photo.attached?
      url = rails_blob_path(current_user.photo, disposition: "attachment", only_path: true)
      render json: {url: url}, status: :ok
    else 
      head :not_found
    end
  end

  private
  def photo_params
    params.permit(:photo)
  end
end