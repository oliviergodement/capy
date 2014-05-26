# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 5.times do
#   User.create
# end


# 3.times do
#   init_cap = (1000..100000).to_a.sample
#   shares = (init_cap / (1000..10000).to_a.sample)
#   Firm.create(name: Faker::Company.name, initial_capital: init_cap, shares: shares,
#               valuation: init_cap, share_price: (init_cap/shares), user_id: 1)
# end

  2.times do
    Shareholder.create(first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, email: Faker::Internet.email, address: Faker::Address.street_address,
                      ownership: (25/100), initial_ownership: (25/100), shares: 100, firm_id: 4)
  end

  5.times do
    Shareholder.create(first_name: Faker::Name.first_name, last_name: Faker::Name.first_name, email: Faker::Internet.email, address: Faker::Address.street_address,
                      ownership: (10/100), initial_ownership: (10/100), shares: 40, firm_id: 4)
  end


