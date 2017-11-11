class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def quit_if_offline(roleplay)
    render 'redirect_to_dashboard', layout: false unless roleplay.online?
  end
end
