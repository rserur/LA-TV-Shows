require 'rails_helper'

feature 'user adds a new character to a TV show', %Q{
  As a site visitor
  I want to add a character of my favorite show
  So that other people can enjoy their crazy antics
} do

#  Acceptance Criteria:
# * I can access a form to add a character on a TV show's page
# * I must specify the character's name and the actor's name
# * I can optionally provide a description
# * If I do not provide the required information, I receive an error message
# * If the character already exists in the database, I receive an error message

  scenario 'user adds a new character' do
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
      description: 'A handsome bastard.'
    }

    character = Character.new(attrs)

    visit "/television_shows/1/characters/new"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content character.name
    expect(page).to_not have_content character.description
  end

  scenario 'without required attributes' do

    attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.new(attrs)

    visit "/television_shows/1/characters/new"
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add a character who is already in the database' do

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
      description: 'A handsome bastard.'
    }

    character = Character.new(attrs)

    visit "/television_shows/1/characters/new"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

     visit "/television_shows/1/characters/new"
    fill_in 'Name', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end
