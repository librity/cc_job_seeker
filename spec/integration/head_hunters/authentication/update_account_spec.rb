# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunters ' do
  scenario 'can change their password' do
    head_hunter = log_head_hunter_in!

    visit root_path
    within 'li#account_dropdown' do
      click_on I18n.t('views.navigation.change_password')
    end

    new_password = Faker::Internet.password min_length: 8

    fill_in I18n.t('activerecord.attributes.head_hunter.password'), with: new_password
    fill_in I18n.t('activerecord.attributes.head_hunter.password_confirmation'), with: new_password
    fill_in I18n.t('activerecord.attributes.head_hunter.current_password'), with: head_hunter.password
    within 'form#edit_head_hunter' do
      click_on I18n.t('views.actions.update')
    end

    expect(page).to have_content I18n.t('devise.registrations.updated')
    click_on I18n.t('views.actions.log_out')
    within 'li#hunter_dropdown' do
      click_on I18n.t('views.navigation.log_in')
    end

    fill_in I18n.t('activerecord.attributes.head_hunter.email'), with: head_hunter.email
    fill_in I18n.t('activerecord.attributes.head_hunter.password'), with: new_password
    within 'form' do
      click_on I18n.t('views.actions.log_in')
    end

    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(current_path).to eq hunter_dashboard_path
  end

  xscenario "can't change their email" do
  end
end
