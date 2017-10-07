class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @own_roleplays = current_user.roleplays
    @characters = current_user.characters
    @new_character = Character.new()
  end


end
