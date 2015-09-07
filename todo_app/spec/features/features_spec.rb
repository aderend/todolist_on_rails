require 'rails_helper'

feature 'list management' do

  let!(:sample_list) {List.create!(category: Faker::Lorem.word, created_by: Faker::Name.name)}

  scenario "user can see list of lists on index page" do
    visit "/"
    save_and_open_page
    expect(page).to have_content(sample_list.category.capitalize)
  end

end
