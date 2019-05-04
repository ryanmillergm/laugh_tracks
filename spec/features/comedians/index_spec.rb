require 'rails_helper'

RSpec.describe "an unauthenticated user visiting welcome page" do
  before :each do
    Special.destroy_all
    Comedian.destroy_all
  end
  it "should see a comedians age, name and city" do
    comedian = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    visit '/comedians'

    within("#comedian-#{comedian.id}") do
    expect(page).to have_content("Age: #{comedian.age}")
    expect(page).to have_content(comedian.name)
    expect(page).to have_content("Born in: #{comedian.city}")
    end
  end

  it "should see comedians specials and run time" do
    comedian = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    special = comedian.specials.create(name: "FOX", runtime_minutes: 30, image_url: "google.com")
    visit '/comedians'

    expect(page).to have_content("TV special: #{special.name}")
    expect(page).to have_content("Run time: #{special.runtime_minutes} minutes")
    expect(page).to have_xpath('//img[@src="google.com"]')
  end

  it "list of comedians by age" do
    comedian_1 = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    comedian_2 = Comedian.create(name: "Paul", age: 34, city: "Denver", image_url: "google.com")
    visit '/comedians?age=34'

    expect(page).to have_content(comedian_2.name)
    expect(page).to_not have_content(comedian_1.name)
  end

  it "should git a count comedians specials" do
    comedian = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    special = comedian.specials.create(name: "FOX", runtime_minutes: 30, image_url: "google.com")
    special_2 = comedian.specials.create(name: "ABC", runtime_minutes: 60, image_url: "google.com")
    visit '/comedians'

    expect(page).to have_content("Number of appearances: #{comedian.specials_count}")
  end

  it "the user sees statistics" do
    visit '/comedians'

    expect(page).to have_content("Statistics")
  end

  it "the user sees statistics with average age" do
    comedian_1 = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    comedian_2 = Comedian.create(name: "Paul", age: 34, city: "Denver", image_url: "google.com")
    visit '/comedians'

    expect(page).to have_content("Average age of comedians: 29")
  end

  it "the user sees statistics with unique cities" do
    comedian_1 = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    comedian_2 = Comedian.create(name: "Paul", age: 34, city: "Denver", image_url: "google.com")
    comedian_3 = Comedian.create(name: "Alex", age: 20, city: "Los Angeles", image_url: "google.com")
    visit '/comedians'

    expect(page).to have_content("Cities of comedians: Denver, Los Angeles")
  end

  it "the user sees that the comedians have links" do
    comedian_1 = Comedian.create(name: "John", age: 24, city: "Denver", image_url: "google.com")
    comedian_2 = Comedian.create(name: "Paul", age: 34, city: "Denver", image_url: "google.com")
    comedian_3 = Comedian.create(name: "Alex", age: 20, city: "Los Angeles", image_url: "google.com")
    visit '/comedians'

    save_and_open_page
    expect(page).to have_link("#{comedian_1.name}", href: "/comedians/#{comedian_1.id}" )
    expect(page).to have_link("#{comedian_2.name}", href: "/comedians/#{comedian_2.id}" )
    expect(page).to have_link("#{comedian_3.name}", href: "/comedians/#{comedian_3.id}" )
  end
  # clicks on a comedian and is redirected to that comedians info

  # User Story 7
  #
  # As a visitor
  # When I visit `/comedians`
  # Then I see an area at the top of the page called 'Statistics'
  # In that 'Statistics' area, I see the following information:
  # - the average age of all comedians on the page (if the page is
  # filtered for specific comedians, the statistics should reflect the new group)
  # - a unique list of cities for each comedian on the page
  #
  # Averaging and uniqueness should be done in ActiveRecord NOT
  # using Ruby

end
