class Admin::DashboardController < ApplicationController
  def show
    @total_products = Product.all.count
    @total_categories = Category.all.count
  end
end
