module IntegrationTest
  module Shared
    def i_can_see_sign_in_form
      within('#engagements-user-logged-state') do
        expect(page).to have_selector('input[name="user[email]"]')
        expect(page).to have_selector('input[name="user[password]"]')

        sign_in_button = find('input.btn.btn-primary')
        expect(sign_in_button['value']).to eq('Sign In')
        expect(page).to have_selector('a.btn.btn-secondary', text: 'Sign Up')
      end
    end

    def i_can_sign_in(email:, password: 'ThisIs@Very5Pass')
      within('#engagements-user-logged-state') do
        fill_in 'user[email]', with: email
        fill_in 'user[password]', with: password
        click_on 'Sign In'
      end
    end

    def i_can_sign_in_as_smith
      i_can_sign_in(email: 'smith@remitano.com')
    end

    def i_can_sign_in_as_john
      i_can_sign_in(email: 'john@remitano.com')
    end

    def i_can_see_welcome_banner(expected_email:)
      within('#engagements-user-logged-state') do
        expect(page).to have_selector('div', text: "Welcome #{expected_email}")
        expect(page).to have_selector('a.btn.btn-primary', text: 'Share a movie')
        expect(page).to have_selector('a.btn.btn-secondary', text: 'Sign Out')
      end
    end

    def i_can_see_list_of_shared_videos(total: 2)
      expect(page).to have_selector('div.shared-video', count: total)

      within('div.shared-video:nth-child(1)') do
        expect(page).to have_selector('iframe[src="https://www.youtube.com/embed/HsAxx81QlwY"]')
        expect(page).to have_selector('div', text: 'Big Game of Thrones (Full Episode) | Savage Kingdom')
        expect(page).to have_selector('div', text: 'Shared by: john@remitano.com')
        expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_up')
        expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_down')
        expect(page).to have_selector('div', text: 'Description:')
        expect(page).to have_selector('div', text: 'Rule of the kingdom is reserved for the strong. Five heroes, each with a unique power, head up rival clans struggling for power, clawing their way to the top...')
      end

      within('div.shared-video:nth-child(2)') do
        expect(page).to have_selector('iframe[src="https://www.youtube.com/embed/eZ2Rt2DVGdU"]')
        expect(page).to have_selector('div', text: "Underwater Killers (Full Episode) | World's Deadliest")
        expect(page).to have_selector('div', text: 'Shared by: smith@remitano.com')
        expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_up')
        expect(page).to have_selector('span.text-sm.material-icons.material-symbols-outlined', text: 'thumb_down')
        expect(page).to have_selector('div', text: 'Description:')
        expect(page).to have_selector('div', text: 'Nat Geo WILD gets up close with underwater killers lurking in our oceans. At first glance these underwater assassins may appear to be exotic beauties, but fo...')
      end
    end

    def i_can_sign_out
      within('#engagements-user-logged-state') do
        click_on 'Sign Out'
      end
    end
  end
end
