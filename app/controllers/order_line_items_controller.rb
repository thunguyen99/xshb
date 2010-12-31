class OrderLineItemsController < ApplicationController
  before_filter :login_required

  def create
    puts "@@@@@@@@@"
    render :text => "ok"
  end

end
