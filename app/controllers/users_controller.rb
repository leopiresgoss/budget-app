class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /add-money
  def add_money_view; end

  def add_money
    current_user.balance += params[:amount].to_f
    current_user.save

    redirect_to root_path
  rescue e
    redirect_to add_money_view_path, alert: e.message
  end
end
