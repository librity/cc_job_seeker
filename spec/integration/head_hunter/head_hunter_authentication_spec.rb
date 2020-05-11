# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter authentication' do
  context 'log in' do
    scenario 'successfully' do
      head_hunter = HeadHunter.create! email: 'test@example.com.br', password: '12345678'

      visit root_path
      click_on I18n.t('views.navigation.head_hunter.login')
      expect(current_path).to eq new_head_hunter_session_path

      fill_in I18n.t('activerecord.attributes.head_hunter.email'), with: head_hunter.email
      fill_in I18n.t('activerecord.attributes.head_hunter.password'), with: head_hunter.password
      within 'form' do
        click_on I18n.t('views.actions.log_in')
      end

      expect(page).to have_content I18n.t('devise.sessions.signed_in')

      expect(page).to have_link I18n.t('views.actions.log_out'),
                                href: destroy_head_hunter_session_path
      expect(page).not_to have_link I18n.t('views.navigation.head_hunter.login'),
                                    href: new_head_hunter_session_path
      expect(page).not_to have_link I18n.t('views.navigation.head_hunter.signup'),
                                    href: new_head_hunter_registration_path

      expect(current_path).to eq head_hunters_dashboard_path
    end

    scenario 'and must fill in all fields' do
      visit root_path
      click_on I18n.t('views.navigation.head_hunter.login')
      expect(current_path).to eq new_head_hunter_session_path

      within 'form' do
        click_on I18n.t('views.actions.log_in')
      end

      expect(page).to have_content I18n.t('devise.failure.invalid',
                                          authentication_keys: I18n.t('activerecord.attributes.head_hunter.email'))

      expect(page).not_to have_link I18n.t('views.actions.log_out'),
                                    href: destroy_head_hunter_session_path
      expect(page).to have_link I18n.t('views.navigation.head_hunter.login'),
                                href: new_head_hunter_session_path
      expect(page).to have_link I18n.t('views.navigation.head_hunter.signup'),
                                href: new_head_hunter_registration_path
    end
  end

  context 'log out' do
    scenario 'successfully' do
      head_hunter = HeadHunter.create! email: 'test@example.com.br', password: '12345678'

      visit root_path
      click_on I18n.t('views.navigation.head_hunter.login')
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
      expect(page).to have_link I18n.t('views.navigation.head_hunter.login'),
                                href: new_head_hunter_session_path
      expect(page).to have_link I18n.t('views.navigation.head_hunter.signup'),
                                href: new_head_hunter_registration_path

      expect(current_path).to eq root_path
    end
  end
end
