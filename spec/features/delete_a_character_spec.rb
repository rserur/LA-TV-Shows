require 'rails_helper'

feature 'user deletes a new character to a TV show', %Q{
As a site visitor
I want to delete a character I don't like
So no one else will want to watch that character
} do

# Acceptance Criteria:
# * I can delete a character from the database
# * If the record is not successfully deleted, I receive an error message

  scenario 'user deletes a character' do
    attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.new(attrs)

    attrs = {
      name: 'Jon Snow',
      actor: 'Kit Harington',
      description: 'A handsome bastard.',
      television_show_id: '1'
    }

    character = Character.create(attrs)

    visit "/television_shows/1/characters/#{character.id}"
    click_link('Delete Character')

    expect(page).to have_content 'Deleted'
    expect(page).to have_content character.name
  end

end
