# frozen_string_literal: true

require 'rails_helper'

feature 'User authentication' do
  context 'log in' do
    scenario 'successfully' do
      user = User.create! email: 'test@example.com.br', password: '12345678'

      visit root_path
      expect(current_path).to eq new_user_session_path

      fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
      fill_in I18n.t('activerecord.attributes.user.password'), with: user.password
      within 'form' do
        click_on I18n.t('views.actions.log_in')
      end

      expect(page).to have_content I18n.t('devise.sessions.signed_in')
      expect(page).to have_link I18n.t('views.actions.log_out'), href: destroy_user_session_path
      expect(page).not_to have_link I18n.t('views.navigation.log_in')
      expect(current_path).to eq root_path
    end

    scenario 'and must fill in all fields' do
      visit root_path
      expect(current_path).to eq new_user_session_path

      within 'form' do
        click_on I18n.t('views.actions.log_in')
      end

      expect(page).to have_content I18n.t('devise.failure.invalid',
                                          authentication_keys: I18n.t('activerecord.attributes.user.email'))
      expect(page).to have_link I18n.t('views.navigation.log_in'), href: new_user_session_path
      expect(page).not_to have_link I18n.t('views.actions.log_out')
    end
  end

  context 'log out' do
    scenario 'successfully' do
      user = User.create! email: 'test@example.com.br', password: '12345678'

      visit root_path
      expect(current_path).to eq new_user_session_path

      fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
      fill_in I18n.t('activerecord.attributes.user.password'), with: user.password
      within 'form' do
        click_on I18n.t('views.actions.log_in')
      end
      click_on I18n.t('views.actions.log_out')

      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
      expect(page).to have_link I18n.t('views.navigation.log_in'), href: new_user_session_path
      expect(page).not_to have_link(I18n.t('views.actions.log_out'))
      expect(current_path).to eq new_user_session_path
    end
  end
end
