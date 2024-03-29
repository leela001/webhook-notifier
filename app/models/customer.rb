class Customer < ApplicationRecord
    validates :first_name,:phone_number presence :true
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validate_format_of :email, :with => email_regex, :allow_blank => true




    def save_customer(params, customer_id = nil)
        if customer_id.present?
            customer = Customer.find_by_id(customer_id)
        end
        customer = Customer.new unless customer.present?
        customer.first_name = params.first_name
        customer.last_name = params.last_name
        customer.email = params.email
        customer.phone_number = params.phone_number
        customer.save!
    end
end
