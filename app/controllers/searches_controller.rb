class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def search
    if params[:keyword].present?
      @rooms = Room.where(["name LIKE? OR introduce LIKE? OR address LIKE?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"])
    elsif params[:area].present?
      @rooms = Room.where(["address like?","%#{params[:area]}%"])
    end
  end
end
