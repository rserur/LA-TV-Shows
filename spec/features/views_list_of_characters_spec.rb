require 'rails_helper'

feature 'user views list of characters', %Q{
As a site visitor
I want to view a list of people's favorite TV characters
So I can find wonky characters to watch
} do

# Acceptance Criteria:
# * I can see a list of all the characters
# * The character's name and the TV show it is associated with are listed

  scenario 'user views characters' do

    attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.new(attrs)

    characters = []
    char_attrs = [
      { name: 'George Murphington', actor: 'Ethel Merman', description: 'The guy in the field.', television_show_id: '1'},
      { name: 'Beril Murphington', actor: 'Frank Jelly', description: 'The lady in the field.', television_show_id: '1'},
      { name: 'Cat Callington', actor: 'Georgia Betty', description: 'The two dragons.', television_show_id: '1'},
    ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end

    visit '/television_shows/1/characters'
    characters.each do |character|
      expect(page).to have_content character.name
      expect(page).to have_content character.actor
    end
  end
end
