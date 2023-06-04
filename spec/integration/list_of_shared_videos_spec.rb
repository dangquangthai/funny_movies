require 'rails_helper'

RSpec.describe 'List of shared videos', type: :system do
  scenario 'As a visitor i can see that list of shared videos' do
    visit root_path
    i_can_see_sign_in_form
    i_can_see_list_of_shared_videos
  end

  scenario 'As a logged-in user i can see that list of shared videos' do
    visit root_path
    i_can_see_sign_in_form
    i_can_sign_in_as_smith
    i_can_see_welcome_banner(expected_email: 'smith@remitano.com')
    i_can_see_list_of_shared_videos
  end
end
