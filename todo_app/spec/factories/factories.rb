FactoryGirl.define do

  factory(:list) do
    category Faker::Lorem.word
    created_by Faker::Name.name
    factory(:invalid_list) do
      category nil
    end
  end

  factory(:task) do
    name Faker::Lorem.word
  end

end
