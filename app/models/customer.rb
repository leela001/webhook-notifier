class Customer < ApplicationRecord
    validates :first_name, presence: true
    validates :phone_number, presence: true, length: {is: 10}, numericality: {only_integer: true, message: "is not a number"}
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :email, :with => email_regex, :allow_blank => true




    def self.save_customer(params, customer_id = nil)
        if customer_id.present?
            customer = Customer.find_by_id(customer_id)
            raise Exception.new("Invalid Customer_id: #{customer_id}") unless customer.present?
        else
            customer = Customer.new 
        end
        customer.first_name = params["first_name"]
        customer.last_name = params["last_name"]
        customer.email = params["email"]
        customer.phone_number = params["phone_number"]
        customer.save!
        return customer
    end
end
