require 'rails_helper'

RSpec.describe 'Realtime notification', type: :system do
  fixtures :users

  let(:john) { users(:john) }

  before do
    Notification.all.destroy_all
  end

  scenario 'As a visitor i can not see realtime notification when someone sharing a video' do
    visit root_path

    it_do_not_subscribe_to_notification_channel
    john_sharing_a_video
  end

  scenario 'As John i can not see realtime notification when i sharing a video' do
    visit root_path

    it_do_not_subscribe_to_notification_channel
    i_can_sign_in_as_john
    it_subscribed_to_notification_channel
    john_sharing_a_video
    i_can_not_see_notification
  end

  scenario 'As Smith i can see realtime notification when John sharing a video' do
    visit root_path

    it_do_not_subscribe_to_notification_channel
    i_can_sign_in_as_smith
    it_subscribed_to_notification_channel
    john_sharing_a_video
    i_can_see_one_notification
    john_sharing_another_video
    i_can_see_two_notifications
  end

  def i_can_not_see_notification
    within('div[data-controller="notifications"]') do
      expect(page).not_to have_selector('div[data-controller="notification"]')
    end
  end

  def i_can_see_one_notification
    within('div[data-controller="notifications"]') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 1)
      expect(page).to have_selector('div', text: 'John shared This is title video with you')
    end
  end

  def i_can_see_two_notifications
    within('div[data-controller="notifications"]') do
      expect(page).to have_selector('div[data-controller="notification"]', count: 2)
      expect(page).to have_selector('div', text: 'John shared This is Another title video with you')
    end
  end

  def it_do_not_subscribe_to_notification_channel
    expect(page).not_to have_selector('div[data-controller="notifications"]')
    expect(page).not_to have_selector('div[data-controller="subscribe"]', visible: false)
  end

  def it_subscribed_to_notification_channel
    expect(page).to have_css('div[data-controller="notifications"]')
    expect(page).to have_css('div[data-controller="subscribe"]', visible: false)
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
