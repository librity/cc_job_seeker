# frozen_string_literal: true

require 'rails_helper'

feature 'Admin can edit a car category' do
  before :each do
    log_user_in!
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

  xscenario 'and name must be unique' do
    car_category_one = CarCategory.create! name: 'Sedan', daily_rate: 100.0,
                                           insurance: 10.0, third_party_insurance: 5.0
    CarCategory.create! name: 'Camião', daily_rate: 140.0, insurance: 20.0,
                        third_party_insurance: 15.0

    visit root_path
    click_on I18n.t('activerecord.models.car_category.other')
    within "tr#car-category-#{car_category_one.id}" do
      click_on I18n.t('views.navigation.details')
    end
    click_on I18n.t('views.navigation.edit')
    fill_in I18n.t('activerecord.attributes.attr_defaults.name'), with: 'Camião'
    click_on I18n.t('views.actions.send')

    expect(page).to have_content(I18n.t('errors.messages.taken'))
  end
end
