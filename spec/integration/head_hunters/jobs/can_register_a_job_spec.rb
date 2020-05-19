# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can register a job' do
  before :each do
    log_head_hunter_in!
    Faker::Job.unique.clear
  end

  scenario 'from index page' do
    visit root_path
    click_on I18n.t('activerecord.models.job.other')

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_head_hunters_job_path
  end

  scenario 'successfully' do
    visit root_path
    click_on  I18n.t('activerecord.models.job.other')
    click_on  I18n.t('views.navigation.new')

    job_attributes = build :job
    fill_in I18n.t('activerecord.attributes.job.position'), with: job_attributes.position
    fill_in I18n.t('activerecord.attributes.job.title'), with: job_attributes.title
    fill_in I18n.t('activerecord.attributes.job.description'), with: job_attributes.description
    fill_in I18n.t('activerecord.attributes.job.skills'), with: job_attributes.skills
    fill_in I18n.t('activerecord.attributes.job.salary_floor'), with: job_attributes.salary_floor
    fill_in I18n.t('activerecord.attributes.job.salary_roof'), with: job_attributes.salary_roof
    fill_in I18n.t('activerecord.attributes.job.location'), with: job_attributes.location
    fill_in I18n.t('activerecord.attributes.job.expires_on'), with: job_attributes.expires_on
    click_on I18n.t('views.actions.send')

    expect(current_path).to eq head_hunters_job_path(Job.last.id)
    expect(page).to have_content I18n.t('flash.created',
                                        resource: I18n.t('activerecord.models.job.one'))

    expect(page).to have_content job_attributes.position.titleize
    expect(page).to have_content job_attributes.title.titleize
    expect(page).to have_content job_attributes.description
    expect(page).to have_content job_attributes.skills.titleize
    expect(page).to have_content job_attributes.location.titleize

    expect(page).to have_content number_to_currency(job_attributes.salary_floor)
    expect(page).to have_content number_to_currency(job_attributes.salary_roof)

    expect(page).to have_content I18n.l(job_attributes.expires_on)
    expect(page).to have_link I18n.t('views.navigation.go_back'), href: head_hunters_jobs_path
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
      .t('activerecord.errors.models.job.attributes.expires_on.at_least_one_month_from_now')
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
