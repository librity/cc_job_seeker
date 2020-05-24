# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can register a job' do
  before :each do
    log_head_hunter_in!
    Faker::Job.unique.clear
  end

  scenario 'and must fill in all fields' do
    visit root_path
    click_on I18n.t('activerecord.models.job.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.job.title'), with: '   '
    fill_in I18n.t('activerecord.attributes.job.description'), with: ' '
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('errors.messages.blank'), count: 7
  end

  scenario 'and description should be at least 50 characters long' do
    visit root_path
    click_on I18n.t('activerecord.models.job.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.job.description'), with: 'a' * 49
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('errors.messages.too_short', count: 50)
  end

  scenario 'and expiration date must be valid' do
    visit root_path
    click_on I18n.t('activerecord.models.job.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.job.expires_on'), with: 'dsa211$'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n.t('errors.messages.invalid'), count: 1
  end

  scenario 'and expiration date must be at least one month from now' do
    visit root_path
    click_on I18n.t('activerecord.models.job.other')
    click_on I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.job.expires_on'), with: 1.month.from_now - 2.days
    click_on I18n.t('views.actions.send')

    expect(page).to have_content I18n
      .t('activerecord.errors.models.job.attributes.expires_on.before_one_month')
  end

  scenario 'and salary floor should be at least minimum wage' do
    visit root_path
    click_on  I18n.t('activerecord.models.job.other')
    click_on  I18n.t('views.navigation.new')

    fill_in I18n.t('activerecord.attributes.job.salary_floor'), with: 1038
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.greater_than_or_equal_to', count: 1039))
  end
end
