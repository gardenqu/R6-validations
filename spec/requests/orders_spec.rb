require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  describe "get orders_path" do
    it "renders the index view" do
      FactoryBot.create_list(:customer, 10)
      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "get order_path" do
    it "renders the :show template" do
      customer = FactoryBot.create(:customer)
      order=customer.orders.create(product_name:"Skittles",product_count:3)
      get order_path(id: order.id)
      expect(response).to render_template(:show)
    end

    it "redirects to the index path if the order id is invalid" do
      get order_path(id: 5000) #an ID that doesn't exist
      expect(response).to redirect_to orders_path
    end
  end

describe "get new_order_path" do
    it "renders the :new template"do
    get new_order_path
    expect(response).to render_template(:new)
end
  end
  describe "get edit_order_path" do
    it "renders the :edit template"do
    customer = FactoryBot.create(:customer)
    order= FactoryBot.create(:order, customer_id: customer.id)
    get edit_order_path(id: order.id)
    order.reload
    expect(response).to render_template(:edit)
  end
  end


  describe "post  orders_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      
      customer = FactoryBot.create(:customer)
      order = FactoryBot.attributes_for(:order, customer_id: customer.id)

      expect { 
        post orders_path,  params: {order: order}

      }.to change(Order, :count)
      expect(response).to redirect_to order_path(id: Order.last.id)
    end
  end


  describe "post orders_path with invalid data" do
    it "does not save a new entry or redirect" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      order_attributes.delete(:product_name)
      expect { post orders_path, params: {order: order_attributes}
    }.to_not change(Order, :count)
      expect(response).to render_template(:new)
    end
  end

  describe "put order_path with valid data" do
    it "updates an entry and redirects to the show path for the order" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer_id: customer.id)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)

      expect { put order_path(id: order.id), params: {order: order_attributes}
    }.to_not change(Order, :count)
    expect(response).to redirect_to order_path(id: Customer.last.id)
    end
  end



  describe "put order_path with invalid data" do
    it "does not update the order record or redirect" do
      customer = FactoryBot.create(:customer)
      order = FactoryBot.create(:order, customer_id: customer.id)
      order.product_name=nil
      expect { put order_path(id: order.id), params: {order: {customer_id: order.customer_id, product_name: order.product_name, product_count: order.product_count}}
  }.to_not change(Order, :count)
    expect(response).to render_template(:edit)
  end
  end


  describe "delete a customer record" do
    it "deletes a customer record"do
    customer = FactoryBot.create(:customer)
    order = FactoryBot.create(:order, customer_id: customer.id)
    expect do
      delete order_path(id: order.id)
    end.to change(Order, :count).by(-1)
  
  end
  end


end
