require 'faker'

Order.transaction do
    (1..100).each do |i|
        Order.create(name: Faker::Name.name, address: Faker::address, email: Fakker::Internet.email, pay_type: "Check")
    end
end

