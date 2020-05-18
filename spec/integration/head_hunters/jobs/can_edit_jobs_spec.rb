# frozen_string_literal: true

require 'rails_helper'

feature 'Head Hunter can edit a job' do
  before :each do
    log_head_hunter_in!
  end

  xscenario 'successfully' do
    car_category_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                           insurance: 10.0, third_party_insurance: 5.0

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    within "tr#car-category-#{car_category_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Camião'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content('Camião')
    expect(page).to have_content I18n.t('views.messages.successfully.updated',
                                        resource: I18n.t('activerecord.models.car_category.one'))
  end

  xscenario 'and name can not be blank' do
    car_category_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                           insurance: 10.0, third_party_insurance: 5.0

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    within "tr#car-category-#{car_category_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: ''
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.blank'))
  end
end
