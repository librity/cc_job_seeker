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

    expect(page).to have_link I18n.t('views.navigation.new'), href: new_hunter_job_path
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

    expect(current_path).to eq hunter_job_path(Job.last.id)
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
    expect(page).to have_link I18n.t('views.navigation.go_back')
  end
end
