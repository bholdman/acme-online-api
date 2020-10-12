class V1::SubscriptionsController < ApplicationController

  before_action :authorize_request

  def index
    # Return all subscriptions available
    subscriptions = Subscription.all
    render json: subscriptions, status: :ok
  end

  def subscribe
    # Try and find the customer so we don't create a new one if we don't need to
    customer = Customer.find_by(email: params[:email])
    customer = CustomerService.new().create_customer(customer_params) if customer.blank?
    
    # If we couldn't create the customer for some reason return an error
    render json: {error: 'Customer not created'}, status: :unprocessable_entity and return if customer.id.blank?

    # Check to see if we were sent a valid subscription
    subscription = Subscription.find_by(subscription_id: subscription_params[:subscription_id])

    # If we didn't find a subscription return an error
    render json: {error: 'Subscription not found'}, status: :not_found and return if subscription.blank?

    # All is good, let's create a subscription for this customer
    customer_subscription = SubscriptionService.new(customer, subscription, payment_params).create_customer_subscription

    # Render the message returned from the payment processor showing success or error in creating the subscription
    render json: customer_subscription
    
  end

  private 

  def customer_params
    params.permit(:first_name, :last_name, :email, :address1, :address2, :city, :state, :zip_code)
  end

  def subscription_params
    params.permit(:subscription_id)
  end

  def payment_params
    params.permit(:card_number, :last_4, :expiration_month, :expiration_year, :cvv, :zip_code)
  end

end