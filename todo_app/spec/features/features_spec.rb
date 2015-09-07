require 'rails_helper'

feature 'list management' do

  let!(:sample_list) {List.create!(category: Faker::Lorem.word, created_by: Faker::Name.name)}
  let!(:sample_task) {Task.create!(name: Faker::Lorem.word, list_id: sample_list.id)}

  scenario "user can see list of lists on index page" do
    visit "/"
    expect(page).to have_content(sample_list.category.capitalize)
  end

  scenario "clicking on list name takes you list page" do
    visit "/"
    click_link(sample_list.category.capitalize)
    save_and_open_page
    expect(page).to have_content(sample_list.category)
    expect(page).to have_content(sample_task.name)
  end

end
