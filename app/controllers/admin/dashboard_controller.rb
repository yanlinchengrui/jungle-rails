class Admin::DashboardController < ApplicationController

  # before_filter :authorize
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  def show
  end
end
