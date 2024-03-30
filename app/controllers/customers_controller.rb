class CustomersController < ApplicationController

    protect_from_forgery

    def create_customer
        begin
            @customer = Customer.save_customer(params)
            if @customer.present?
                notify_webhook_url(@customer)
                render :json => @customer
            end
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
            if @customer.present?
                notify_webhook_url(@customer)
                render :json => @customer
            end
        rescue Exception => e
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end


    def destroy
        begin
            @customer = Customer.find(params["id"])
            @customer.delete
            render :json => {message: "customer record deleted", customer_id: params["id"]}
        rescue Exception => e
            render :json => {message: e.message}, status: :unprocessable_entity
        end
    end

    private
        def notify_webhook_url(data)
            urls = Rails.application.config.webhook_urls
            begin
                urls.each do |uri|
                    conn = Faraday.new(:url => uri) do |builder|
                        builder.request     :url_encoded
                        builder.response    :logger
                        builder.adapter     :net_http
                    end

                    resp = conn.post do |req|
                        req.headers["Content-Type"] = "application/json"
                        req.body =  data.to_json
                    end
                    if resp.status == 200
                        Rails.logger.info("Successfully notified #{uri}: #{resp.status} -- response body: #{JSON.parse(resp.body)}")
                    else
                        Rails.logger.error("Failed to notify #{uri}: #{resp.status} -- response body: #{JSON.parse(resp.body)}")
                    end
                end
            rescue Exception => e
                Rails.logger.error("Error while notifying the webhook urls: #{urls}")
            end
        end

end
