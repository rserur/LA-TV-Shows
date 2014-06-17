require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can find learn more about it
  I can see a the show's title, network, the years it ran, and a synopsis.
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.
  # * For each character, I can see the character's name, actor's
  # name, and the character's description

  scenario "user views a TV show's details with character information" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )

    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis

    characters = []
    char_attrs = [
      { name: 'George Murphington', actor: 'Ethel Merman', description: 'The guy in the field.', television_show_id: "#{show.id}"},
      { name: 'Beril Murphington', actor: 'Frank Jelly', description: 'The lady in the field.', television_show_id: "#{show.id}"},
      { name: 'Cat Callington', actor: 'Georgia Betty', description: 'The two dragons.', television_show_id: "#{show.id}"},
    ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end

    visit "/television_shows/#{show.id}"
    characters.each do |character|
      expect(page).to have_content character.name
      expect(page).to have_content character.actor
      expect(page).to have_content character.description
    end
  end
end
