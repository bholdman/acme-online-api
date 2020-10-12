class CustomerSubscriptionRenewalWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

   def perform(customer_id, subscription_id, payment_method_id)
    SubscriptionService.new().renew_customer_subscription(customer_id, subscription_id, payment_method_id)
  end
end