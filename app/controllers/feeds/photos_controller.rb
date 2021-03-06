module Feeds
  class PhotosController < ApplicationController
    before_action :current_user
    #check initializers/feeds.rb for setup info
    def connect
      redirect_to PhotosAPI.connect_url
    end

    def callback
      #i'd rather check response codes for error status?
      if params[:code] != nil
        PhotosAPI.callback(params[:code], current_user.id)
        current_user.update_attribute(:slug, dashboard_path) if current_user.all_accounts_connected? 
        redirect_to edit_user_path(current_user.id)
        flash[:notice] = "Connection to #{PHOTO_PROVIDER} Successful!"

      else
        #redirect to feed sign up page!!
        redirect_to root_path
        flash[:notice] = "Failed to Connect to #{PHOTO_PROVIDER}"
      end
    end
  end
end
