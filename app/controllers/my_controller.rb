class MyController < ApplicationController
  before_filter :login_required

  def orders
    @orders = Order.in_user(current_user).paginate(:all,:per_page=>20,:page => params[:page], :order => 'created_at DESC')
  end

  def order_show
    @order = Order.find(params[:id])
    if @order.user != current_user
      render :text => "不能查看他人订单"
    end
  end

end
