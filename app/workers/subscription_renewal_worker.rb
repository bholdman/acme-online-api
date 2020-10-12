class SubscriptionRenewalWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

   def perform()
    # Get all customer subscriptions that are active and should renew today
    subscriptions = CustomerSubscriptions.where(is_active: true, renews_on: Time.now.beginning_of_day)

    subscriptions.each do |subscription|
      # set the subscription to inactive
      subscription.update(is_active: false)
      # try to renew the subscription
      CustomerSubscriptionRenewalWorker.perform_async(subscription.customer_id, subscription.subscription_id, subscription.payment_method_id)
    end
  end
end