require 'rails_helper'

feature 'list management' do

  let!(:sample_list) {List.create!(category: Faker::Lorem.word, created_by: Faker::Name.name)}
  let!(:sample_task) {Task.create!(name: Faker::Lorem.word, list_id: sample_list.id)}

  scenario "user can see list of lists on index page" do
    visit "/"
    expect(page).to have_content(sample_list.category)
  end

  scenario "each list has an edit button that redirects" do
    visit "/"
    click_button('Edit')
  end

  scenario "edit list page has category and created_by fields filled out" do
    visit "/"
    click_button('Edit')
    category_field = find_field("list_category").value
    created_by_field = find_field("list_created_by").value
    expect(category_field).to have_content(sample_list.category)
    expect(created_by_field).to have_content(sample_list.created_by)
  end

  scenario "editing a list saves successfully" do
    visit "/"
    click_button('Edit')
    new_category = Faker::Lorem.word
    new_created_by = Faker::Name.name
    fill_in("list_category", with: new_category)
    fill_in("list_created_by", with: new_created_by)
    click_button('Update List')
    expect(page).to have_content(new_category)
    expect(page).to have_content(new_created_by)
    save_and_open_page
  end

  # scenario "each list has a delete button that removes the list" do
  # end

  # scenario "clicking on new list button redirects to new list form" do
  # end

  # scenario "filling out new list form saves successfully" do
  # end

  scenario "clicking on list name takes you list page" do
    visit "/"
    click_link(sample_list.category)
    expect(page).to have_content(sample_list.category)
    expect(page).to have_content(sample_task.name)
  end

end

feature 'task management' do
end
