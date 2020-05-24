# frozen_string_literal: true

require 'rails_helper'

describe JobSeeker::Profile::Comment, type: :model do
  let(:subject) { create :job_seeker_profile_comment }

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

  context 'validation: content' do
    it 'cannot be blank' do
      subject.content = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:content]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must have at least 50 characters' do
      subject.content = 'a' * 49

      expect(subject).to_not be_valid
      expect(subject.errors[:content]).to include(I18n.t('errors.messages.too_short', count: 50))
    end
  end
end
