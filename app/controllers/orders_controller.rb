class OrdersController < ApplicationController
  before_filter :login_required,:only => [:new]

  def new
    @order = Order.new
    olis = OrderLineItem.in_user(current_user).all
    if olis.empty?
      redirect_to "/products"
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.user = current_user
    oli = OrderLineItem.in_user(current_user)
    olis = oli.all
    if olis.empty?
      render :text => "购买商品不能空"
      return
    end
    Order.transaction do
      if @order.save
        amount = oli.first(:select=>"sum(total_price) as tp").tp.to_i
        olis.each do |oli|
          oli.update_attribute(:order,@order)
        end
        @order.update_attribute(:amount,amount)
        redirect_to "/orders/#{@order.id}"
      else
        render :action => "new"
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      render :text => "不能查看他人订单"
    end
  end

  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY"

    when "WAIT_SELLER_SEND_GOODS"

    when "WAIT_BUYER_CONFIRM_GOODS"

    when "TRADE_FINISHED"
      @order.pay!
    else
      @order.fail_payment!
    end

  end

  def done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    unless @result = r.success?
      logger.warn(r.message)
    end
  end

  def show_order
    logger.info "show_order!!!"
  end

end