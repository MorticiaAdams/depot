# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# . . .
Product.destroy_all
#
Product.create!(
    title: 'Programming Ruby 1.9 & 2.0', 
    description: 
        %{<p>
            Ruby is the fastest growing and most exciting dynamic language
            out there. If you need to get working programs delivered fast,
            you should add Ruby to your toolbox.
         </p>},
    image_url: 'ruby.jpg',
    price: 29.95)


300.times do |index|
    Product.find_or_create_by!(
        title: Faker::Company.catch_phrase,
        description: Faker::Lorem.paragraph, 
        image_url: "Image #{index}.jpg",
        #price: "%.2f" % (rand * 99) )
        price: Faker::Commerce.price
    )
end

"Created #{Product.count} books."

['banned', 'customer', 'moderator', 'admin'].each do |role|
      Role.find_or_create_by({
          name: role
      })
end

=begin
User.create!(
    name: 'system administrator',
    email: 'admin@pragmatic.com',
    password: 'top-secret',
    last_visit: Time.now - 3.weeks,
    role_id: Role.find_by_name('admin').id
)
=end

Faker::Config.locale = :en
27.times do |index|
    customer = User.new(password: 'top-secret')
    customer.name = Faker::Name.name
    customer.email = Faker::Internet.email(customer.name)
    if User.find_by_name(customer.name) or User.find_by_email(customer.email)
        customer.name = customer_name + ' ' + Faker::Name.suffix
        customer.email = Faker::Internet.email(customer.name)
    end

    customer.last_visit = Faker::Date.between(Time.now - 10.years, Time.now - 2.days)
    customer.role_id = Role.find_by_name('customer').id
    
    customer.save!
end

3.times do |index|
    customer = User.new(password: 'top-secret')
    customer.name = Faker::Name.name
    customer.email = Faker::Internet.email(customer.name)
    if User.find_by_name(customer.name) or User.find_by_email(customer.email)
        customer.name = customer_name + ' ' + Faker::Name.suffix
        customer.email = Faker::Internet.email(customer.name)
    end

    customer.last_visit = Faker::Date.between(Time.now - 10.years, Time.now - 2.days)
    customer.role_id = Role.find_by_name('moderator').id
    
    customer.save!
end

2.times do |index|
    customer = User.new(password: 'top-secret')
    customer.name = Faker::Name.name
    customer.email = Faker::Internet.email(customer.name)
    if User.find_by_name(customer.name) or User.find_by_email(customer.email)
        customer.name = customer_name + ' ' + Faker::Name.suffix
        customer.email = Faker::Internet.email(customer.name)
    end

    customer.last_visit = Faker::Date.between(Time.now - 10.years, Time.now - 2.days)
    customer.role_id = Role.find_by_name('banned').id

    customer.save!
end


