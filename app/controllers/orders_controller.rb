class OrdersController < ApplicationController
    before_action :set_customer, only: %i[update create]
    before_action :set_order, only: %i[show edit update destroy]
    


    def index
        @orders=Order.all
    end

    def show
        
    end

    def new
        @order=Order.new
    end

    def edit
    end


    def update
       # set_customer
        @order.update(order_params)
        redirect_to @customer


    end

    def create
        #set_customer
        @order = @customer.orders.create(order_params)
        redirect_to @customer  
       
    end

    def destroy
        @order.destroy
        redirect_to customer_path(@order.customer_id)
        
    end



    private
    
    def set_order
        @order=Order.find(params[:id])
    end

    def set_customer
        @customer = Customer.find(params[:order][:customer_id])
    end

    def order_params
        params.require(:order).permit(:product_name,:product_count,:customer_id)
    end
  
end
