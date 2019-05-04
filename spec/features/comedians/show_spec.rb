require 'rails_helper'

RSpec.describe "when a user visits the welcome page" do
  it "should see a comedians age, name and city" do
    comedian = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    visit "/comedians/#{comedian.id}"

    save_and_open_page
    within("#comedian-#{comedian.id}") do
    expect(page).to have_content("Age: #{comedian.age}")
    expect(page).to have_content(comedian.name)
    expect(page).to have_content("Born in: #{comedian.city}")
    end
  end
end
