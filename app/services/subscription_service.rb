class SubscriptionService

  def initialize(customer, subscription, payment = nil)
    @customer = customer 
    @subscription = subscription
    @payment = payment
  end

  def create_customer_subscription
    # Process payment for subbscription before creating
    charge_result = charge_for_subscription
    return charge_result if !charge_result["success"]


    # Determine the renewal date based on the term of the subscription so we can easily look up which subscriptions renew each day
    case @subscription.subscription_term
    when "day"
      renewal_date = Time.now + 1.day
    when "week"
      renewal_date = Time.now + 1.week
    when "month"
      renewal_date = Time.now + 1.month
    when "year"
      renewal_date = Time.now + 1.year
    end

    #Save the customer's card info that we can for future use
    payment_method = PaymentMethod.create(customer_id: @customer.id, payment_expires_at: Time.parse("#{@payment[:expiration_month]}/01/#{@payment[:expiration_year]} 00:00:00"), payment_zip_code: @payment[:zip_code], payment_token: charge_result["token"])

    # Create the subscription since payment succeeded
    subscription = CustomerSubscription.create(customer_id: @customer.id, subscription_id: @subscription.id, renews_on: renewal_date.beginning_of_day, payment_method_id: payment_method.id)

    # return the charge result 
    charge_result
  end

  def renew_customer_subscription

  end

  private 

  def charge_for_subscription
    body= {
      "amount": @subscription.subscription_price,
      "card_number": @payment[:card_number],
      "cvv": @payment[:cvv],
      "expiration_month": @payment[:expiration_month],
      "expiration_year": @payment[:expiration_year],
      "zip_code": @payment[:zip_code]
    }
    
    res = JSON.parse RestClient.post("#{ENV['PAYMENT_API_URL']}purchase", body, authorization: "Token token=#{ENV['PAYMENT_API_KEY']}", content_type: 'json', accept: 'json')
  rescue RestClient::ExceptionWithResponse => e
    error = JSON.parse e.response
    {"token"=>nil, "success"=>false, "error_message"=>lookup_payment_error(error["error_code"])}
  end

  def lookup_payment_error(error_code)
    errors = {
      1000001 => "Invalid credit card number",
      1000002 => "Insufficient funds",
      1000003 => "CVV failure",
      1000004 => "Expired card",
      1000005 => "Invalid zip code",
      1000006 => "Invalid purchase amount",
      1000007 => "Invalid token",
      1000008 => "Invalid params: cannot specify both  token  and other credit card params like  card_number, cvv, expiration_month, expiration_year or zip"
    }
    
    errors[error_code]
  end

end