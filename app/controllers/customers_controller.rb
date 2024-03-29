class CustomersController < ApplicationController

    protect_from_forgery

    def create_customer
        begin
            @customer = Customer.save_customer(params)
            render :json => @customer
        rescue Exception => e
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end

    def index
        @customers = Customer.all
        render :json => @customers
    end

    def show
        begin
            @customer = Customer.find(params["id"])
            render :json => @customer
        rescue Exception => e
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end

    def update
        begin
            @customer = Customer.save_customer(params, params["id"])
            render :json => @customer
        rescue Exception => e
            debugger
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end


    def destroy
        begin
            @customer = Customer.find(params["id"])
            @customer.delete
            render :json => {message: "record deleted", customer_id: params["id"]}
        rescue Exception => e
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end
end
