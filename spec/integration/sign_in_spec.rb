require 'rails_helper'

RSpec.describe 'Sign In', type: :system do
  scenario 'As a visitor i can sign in then sign out' do
    visit root_path
    
    i_can_see_sign_in_form
    i_can_sign_in_as_john
    i_can_see_welcome_banner(expected_email: 'john@remitano.com')
    i_can_sign_out

    i_can_see_sign_in_form
    i_can_sign_in_as_smith
    i_can_see_welcome_banner(expected_email: 'smith@remitano.com')
    i_can_sign_out

    i_can_see_list_of_shared_videos
  end

  def i_can_sign_out
    within('#engagements-user-logged-state') do
      click_on 'Sign Out'
    end
  end
end
