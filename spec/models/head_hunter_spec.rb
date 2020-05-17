# frozen_string_literal: true

require 'rails_helper'

describe HeadHunter, type: :model do
  let(:subject) { create :head_hunter }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  context 'validation: email' do
    it 'cannot be blank' do
      subject.email = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it 'cannot be too long' do
      subject.email = 'a' * 244 + '@example.com'

      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to include(I18n.t('errors.messages.too_long', count: 255))
    end

    it 'must be unique' do
      head_hunter = described_class.new email: subject.email

      expect(head_hunter).to_not be_valid
      expect(head_hunter.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end

    it 'should accept valid addresses' do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]

      valid_addresses.each do |valid_address|
        subject.email = valid_address
        expect(subject).to be_valid
      end
    end

    it 'should reject invalid addresses' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com foo@bar..com]

      invalid_addresses.each do |invalid_address|
        subject.email = invalid_address

        expect(subject).to_not be_valid
        expect(subject.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end
    end

    it 'should be saved as lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      subject.email = mixed_case_email

      subject.save
      expect(subject.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context 'validation: password' do
    it 'cannot be blank' do
      subject.password = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:password]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be at least 8 characters long' do
      subject.password = '1234567'

      expect(subject).to_not be_valid
      expect(subject.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 8))
    end
  end

  context 'validation: name' do
    it 'cannot be blank' do
      subject.name = ' '

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include(I18n.t('errors.messages.blank'))
    end

    it 'must be at least 5 characters' do
      subject.name = 'ana'

      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to include(I18n.t('errors.messages.too_short', count: 5))
    end

    it 'should be saved as title-case' do
      subject.name = 'ana schafer'

      subject.save!

      expect(subject.name).to eq 'Ana Schafer'
    end
  end

  context 'validation: social_name' do
    it 'should be saved as title-case' do
      subject.social_name = 'ana schafer'

      subject.save!

      expect(subject.social_name).to eq 'Ana Schafer'
    end
  end

  context 'method: resolve_name' do
    it 'should return social_name if it exists' do
      subject = create :head_hunter, :with_social_name

      expect(subject.resolve_name).to be subject.social_name
    end

    it 'should return name otherwise' do
      expect(subject.resolve_name).to be subject.name
    end
  end
end
