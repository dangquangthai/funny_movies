require 'rails_helper'

RSpec.describe 'Realtime notification', type: :system do
  fixtures :users

  let(:john) { users(:john) }

  before do
    Notification.all.destroy_all
  end

  scenario 'As a visitor i can not see realtime notification when someone sharing a video' do
    visit root_path

    john_sharing_a_video

    expect(page).not_to have_selector('div#notification-tag')
  end

  scenario 'As John i can not see realtime notification when i sharing a video' do
    visit root_path

    i_can_sign_in_as_john
    john_sharing_a_video

    within('#notification-tag') do
      expect(page).not_to have_selector('div[data-controller="notification"]')
    end
  end

  scenario 'As Smith i can see realtime notification when John sharing a video' do
    visit root_path

    i_can_sign_in_as_smith
    john_sharing_a_video

    within('#notification-tag') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 1)
      expect(page).to have_selector('div', text: 'john@remitano.com shared This is title video with you')
    end

    john_sharing_another_video

    within('#notification-tag') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 2)
      expect(page).to have_selector('div', text: 'john@remitano.com shared This is Another title video with you')
    end
  end

  def john_sharing_a_video
    john.videos.youtube.create!(
      source_url: 'https://www.youtube.com/watch?v=Ad22wfm4tJs',
      source_id: 'Ad22wfm4tJs',
      title: 'This is title',
      description: 'This is description')
  end

  def john_sharing_another_video
    john.videos.youtube.create!(
      source_url: 'https://www.youtube.com/watch?v=7IZ-Fek2kzE',
      source_id: '7IZ-Fek2kzE',
      title: 'This is Another title',
      description: 'This is Another description')
  end
end
