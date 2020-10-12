class CustomerService

  def initialize()
    
  end

  def create_customer(customer_params)
    customer = Customer.create(customer_params)
  end

end