class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @characters = current_user.characters.includes(:roleplay)
    @new_character = Character.new
    @participations = Hash.new(0)
    @characters.each do |character|
      @participations[character.roleplay] += 1
    end
  end


end
