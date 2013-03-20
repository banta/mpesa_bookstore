class BookshopOrdersController < ApplicationController
  def index
    #@users = User.all(:joins => :orders, )
    @status_orders = StatusOrder.all(:order => :id)
  end

  def order_status
  end

end
