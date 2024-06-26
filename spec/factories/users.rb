# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string           not null
#  email            :string(255)      not null
#  nickname         :string(20)       not null
#  salt             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_nickname  (nickname) UNIQUE
#
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "Alice#{n}@example.com" }
    sequence(:nickname) { |n| "Alice#{n}" }
    password { "password" }
    password_confirmation { "password" }
  end
end
