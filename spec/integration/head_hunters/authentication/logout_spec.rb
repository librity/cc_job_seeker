# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter logs out' do
  scenario 'successfully' do
    head_hunter = create :head_hunter

    visit root_path
    within 'li#hunter_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end

    expect(current_path).to eq new_head_hunter_session_path

    fill_in I18n.t('activerecord.attributes.head_hunter.email'), with: head_hunter.email
    fill_in I18n.t('activerecord.attributes.head_hunter.password'), with: head_hunter.password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end
    click_on I18n.t('views.actions.log_out')

    expect(page).to have_content I18n.t('devise.sessions.signed_out')

    expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                  href: destroy_head_hunter_session_path
    expect(page).to have_link I18n.t('views.navigation.log_in'),
                              href: new_head_hunter_session_path
    expect(page).to have_link I18n.t('views.navigation.create_account'),
                              href: new_head_hunter_registration_path

    expect(current_path).to eq root_path
  end
end
