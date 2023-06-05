require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  scenario 'As a visitor i can sign up then sign out then sign in back' do
    visit root_path

    click_on 'Sign Up'
    expect(page).to have_selector('h2.font-bold.text-xl', text: 'Sign up')

    i_can_see_sign_up_form
    i_can_not_sign_up_with_email_has_been_taken
    i_can_not_sign_up_with_short_password
    i_can_not_sign_up_with_invalid_password_confirmation
    i_can_sign_up

    i_can_see_welcome_notification_popup
    i_can_see_list_of_shared_videos

    i_can_sign_out
    i_can_sign_in(email: 'john.doe@remitano.com')
    i_can_see_welcome_banner(expected_email: 'john.doe@remitano.com')
  end

  def i_can_see_sign_up_form
    within('#new_user') do
      expect(page).to have_selector('label', text: 'Name')
      expect(page).to have_selector('input[name="user[name]"]')

      expect(page).to have_selector('label', text: 'Email')
      expect(page).to have_selector('input[name="user[email]"]')

      expect(page).to have_selector('label', text: 'Password')
      expect(page).to have_selector('em', text: '(6 characters minimum)')
      expect(page).to have_selector('input[name="user[password]"]')

      expect(page).to have_selector('label', text: 'Password confirmation')
      expect(page).to have_selector('input[name="user[password_confirmation]"]')
    end
  end

  def i_can_not_sign_up_with_email_has_been_taken
    within('#new_user') do
      fill_in 'user[name]', with: 'John Doe'
      fill_in 'user[email]', with: 'john@remitano.com'
      fill_in 'user[password]', with: 'ThisIs@Very5Pass'
      fill_in 'user[password_confirmation]', with: 'ThisIs@Very5Pass'
      click_on 'Create account'
    end

    within('#error_explanation') do
      expect(page).to have_selector('li', text: "Email has already been taken")
    end
  end

  def i_can_not_sign_up_with_short_password
    within('#new_user') do
      fill_in 'user[name]', with: 'John Doe'
      fill_in 'user[email]', with: 'john.doe@remitano.com'
      fill_in 'user[password]', with: 'short'
      fill_in 'user[password_confirmation]', with: 'short'
      click_on 'Create account'
    end

    within('#error_explanation') do
      expect(page).to have_selector('li', text: "Password is too short (minimum is 6 characters)")
    end
  end

  def i_can_not_sign_up_with_invalid_password_confirmation
    within('#new_user') do
      fill_in 'user[name]', with: 'John Doe'
      fill_in 'user[email]', with: 'john.doe@remitano.com'
      fill_in 'user[password]', with: 'ThisIs@Very5Pass'
      fill_in 'user[password_confirmation]', with: 'invalid_password_confirmation'
      click_on 'Create account'
    end

    within('#error_explanation') do
      expect(page).to have_selector('li', text: "Password confirmation doesn't match Password")
    end
  end

  def i_can_sign_up
    within('#new_user') do
      fill_in 'user[name]', with: 'John Doe'
      fill_in 'user[email]', with: 'john.doe@remitano.com'
      fill_in 'user[password]', with: 'ThisIs@Very5Pass'
      fill_in 'user[password_confirmation]', with: 'ThisIs@Very5Pass'
      click_on 'Create account'
    end
  end

  def i_can_see_welcome_notification_popup
    within('div[data-controller="notifications"]') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 1)
      expect(page).to have_selector('div', text: 'Welcome! You have signed up successfully.')
    end
  end
end
