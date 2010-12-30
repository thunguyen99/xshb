class OrdersController < ApplicationController

  def notify
    logger.info "notify!!!"
  end

  def done
    logger.info "done!!!"
  end

  def show_order
    logger.info "show_order!!!"
  end

end
