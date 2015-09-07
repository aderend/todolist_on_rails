require 'rails_helper'

FactoryGirl.define do

  factory(:list) do
    category Faker::Lorem.word
    created_by Faker::Name.name
  end

  factory(:task) do
    name Faker::Lorem.word
  end

end
