## Webhook Notifier
This Rails application provides functionality to do the basic crud operations with basic validations and notify configured third-party API endpoints about the changes. Additionally, it includes functionality to send emails to registered customers.

## Features
- **CustomerModel**: The application includes a `Customer` model with attributes `first_name, last_name, email, phone_number`, along with basic validations.
- **CustomersController**: The `CustomersController` provides endpoints for the crud operations, with basic parameter verification.
- **Third-Party API Integration**: Configurable third-party API endpoints allow notifying external systems about changes of the customer details.
- **Webhook Request Authentication**: Third-party APIs can verify the authenticity of webhook requests.
- **Email Notifications**: Functionality to send emails to customers when certain events occur.
  
**Note**: The email delivery mechanism has not been configured with SMTP settings yet.Instead of sending emails, the email content is stored in the tmp/mail folder for future reference.

## SMTP Configuration
`config.action_mailer.delivery_method = :smtp`
`config.action_mailer.smtp_settings = {
  address: 'smtp.example.com',
  port: 587,
  user_name: 'your_username',
  password: 'your_password',
  authentication: :plain,
  enable_starttls_auto: true
}`

## Configuration
- Configure the third-party API endpoints in the environment file `config/environments/development.rb`
- Configure email settings in the appropriate environment file `config/environments/development.rb`

## Endpoints
- create_customer(`post`)       - http://localhost:3000/customers/create_customer
- update_customer(`put`)        - http://localhost:3000/customers/update/{id}
- get_customer(`get`)           - http://localhost:3000/customers/{id}
- get_list_of_customers(`get`)  - http://localhost:3000/customers
- delete_customer(`delete`)     - http://localhost:3000/customers/delete/{id}

## Sample_Req_Body
`{
    "first_name": "leela",
    "last_name": "pavan",
    "email": "test@gmail.com",
    "phone_number": "1233214562"
}
`
