require 'rails_helper'

RSpec.describe 'Share a video', type: :system do
  fixtures :users

  let(:smith) { users(:smith) }

  scenario 'As a visitor i can not share a video' do
    visit root_path
    i_can_see_sign_in_form

    within('#engagements-user-logged-state') do
      expect(page).not_to have_selector('a.btn.btn-primary', text: 'Share a movie')
    end
  end

  scenario 'As a logged-in user i can share a video' do
    visit root_path
    i_can_see_sign_in_form
    i_can_sign_in_as_smith
    i_can_see_welcome_banner(expected_email: 'smith@remitano.com')

    click_on 'Share a movie'

    i_can_see_share_a_video_form
    i_can_not_share_a_video_with_invalid_url
    i_can_share_a_video_with_youtube_url
    i_can_see_latest_shared_video
    i_can_see_notification_popup
    i_can_close_notification_popup
  end

  def i_can_see_latest_shared_video
    i_can_see_list_of_shared_videos(total: 3)

    within('div.shared-video:nth-child(3)') do
      expect(page).to have_selector('iframe[src="https://www.youtube.com/embed/Ad22wfm4tJs"]')
      expect(page).to have_selector('div', text: "8 Times Wild Animals Surrounds Its Prey So It Can't Escape")
      expect(page).to have_selector('div', text: 'Shared by: smith@remitano.com')
      expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_up')
      expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_down')
      expect(page).to have_selector('div', text: 'Description:')
      expect(page).to have_selector('div', text: "8 Times Wild Animals Surrounds Its Prey So It Can't EscapeNational Geographic Wild is a place for all things animals and for animal-lovers alike. Take a jour...")
    end
  end

  def i_can_see_notification_popup
    within('#notification-tag') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 1)
      expect(page).to have_selector('div', text: 'Video shared successfully')
    end
  end

  def i_can_close_notification_popup
    within('div[data-controller="notification"]') do
      find('span.material-icons.material-symbols-outlined', text: 'close').click
    end
  end

  def i_can_see_share_a_video_form
    within('#new-video') do
      expect(page).to have_selector('h2.font-bold.text-xl', text: 'Share a video')
      expect(page).to have_selector('label', text: 'Youtube URL')
      expect(page).to have_selector('input[name="video[source_url]"]')

      share_button = find('input.btn.btn-primary')
      expect(share_button['value']).to eq('Share')
    end
  end

  def i_can_not_share_a_video_with_invalid_url
    within('#new-video') do
      fill_in 'video[source_url]', with: 'https://www.youtube.com/watch?v=invalid'
      click_on 'Share'
    end

    i_can_see_share_a_video_form

    expect(page).to have_selector('div.text-red-600', text: 'Source url must be a YouTube URL')
  end

  def i_can_share_a_video_with_youtube_url
    within('#new-video') do
      fill_in 'video[source_url]', with: ''
      fill_in 'video[source_url]', with: 'https://www.youtube.com/watch?v=Ad22wfm4tJs'
      click_on 'Share'
    end
  end
end
