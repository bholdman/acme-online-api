require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do

  it 'must fail gracefully when a paramaeter is not specified when trying to create a subscription' do
    post '/v1/auth/login', params: {username: 'bholdman', password: 'qwerty'}
    response_body = JSON.parse(response.body)
    
    post '/v1/subscriptions/subscribe', params: {last_name: 'McTesterson', email: 'test5@tester.com', address1: "123 Main St.", city: "New York", state: "NY", zip_code: "12345", subscription_id: "123456", card_number: "1234567890", expiration_month: "12", expiration_year: "2020", cvv: "123"}, headers: {"Authorization": "Bearer #{response_body["token"]}"}
    response_body = JSON.parse(response.body)
    expect(response_body["error"]).to eql "Customer not created"
  end

  it 'must fail gracefully if payment fails when trying to create a subscription' do
    ENV['PAYMENT_API_URL'] = "https://www.fakepay.io/"
    ENV['PAYMENT_API_KEY'] = "00aa16541631ab570716d340f4a653"
    post '/v1/auth/login', params: {username: 'bholdman', password: 'qwerty'}
    response_body = JSON.parse(response.body)
    
    post '/v1/subscriptions/subscribe', params: {first_name: "tester", last_name: 'McTesterson', email: 'test5@tester.com', address1: "123 Main St.", city: "New York", state: "NY", zip_code: "12345", subscription_id: "uSSnM9Vr8YRNR9scqWiWUC83", card_number: "4242424242424241", expiration_month: "12", expiration_year: "2025", cvv: "123"}, headers: {"Authorization": "Bearer #{response_body["token"]}"}
    response_body = JSON.parse(response.body)
    expect(response_body["error_message"]).to eql "Invalid credit card number"
  end

  it 'should succeed when all information is provided and payment is successful when trying to create a subscription' do
    ENV['PAYMENT_API_URL'] = "https://www.fakepay.io/"
    ENV['PAYMENT_API_KEY'] = "00aa16541631ab570716d340f4a653"
    post '/v1/auth/login', params: {username: 'bholdman', password: 'qwerty'}
    response_body = JSON.parse(response.body)
    
    post '/v1/subscriptions/subscribe', params: {first_name: "tester", last_name: 'McTesterson', email: 'test5@tester.com', address1: "123 Main St.", city: "New York", state: "NY", zip_code: "12345", subscription_id: "uSSnM9Vr8YRNR9scqWiWUC83", card_number: "4242424242424242", expiration_month: "12", expiration_year: "2025", cvv: "123"}, headers: {"Authorization": "Bearer #{response_body["token"]}"}
    response_body = JSON.parse(response.body)
    expect(response_body["success"]).to eql true
  end
end
