# frozen_string_literal: true

require 'rails_helper'

describe JobSeeker::Profile::Favorite, type: :model do
  let(:subject) { create :job_seeker_profile_favorite }

  it 'has relations' do
    expect(subject).to respond_to(:profile)
    expect(subject).to respond_to(:head_hunter)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: profile' do
    it 'cannot be blank' do
      subject.profile = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:profile]).to include(I18n.t('errors.messages.blank'))
    end
  end

  context 'validation: head_hunter' do
    it 'cannot be blank' do
      subject.head_hunter = nil

      expect(subject).to_not be_valid
      expect(subject.errors[:head_hunter]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
