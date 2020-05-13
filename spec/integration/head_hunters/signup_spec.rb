# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can signup' do
  scenario 'successfully' do
    visit root_path
    within 'li#head_hunters_dropdown' do
      click_on I18n.t('views.navigation.create_account')
    end

    fill_in I18n.t('activerecord.attributes.head_hunter.email'), with: 'test@example.com.br'
    fill_in I18n.t('activerecord.attributes.head_hunter.password'), with: '12345678'
    fill_in I18n.t('activerecord.attributes.head_hunter.password_confirmation'), with: '12345678'
    within 'form' do
      click_on I18n.t('views.actions.sign_up')
    end

    expect(page).to have_content I18n.t('devise.registrations.signed_up')

    expect(page).to have_link I18n.t('views.actions.log_out'),
                              href: destroy_head_hunter_session_path
    expect(page).not_to have_link I18n.t('views.navigation.log_in'),
                                  href: new_head_hunter_session_path
    expect(page).not_to have_link I18n.t('views.navigation.create_account'),
                                  href: new_head_hunter_registration_path
  end
end
