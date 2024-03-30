class CustomerMailer < ApplicationMailer


    def welcome_mail_customer(data)
        mail(:to => data&.email, :subject => "Welcome!", :body => "#{data.to_json}")
    end
end
