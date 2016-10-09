# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  identity               :string           default(""), not null
#  nickname               :string
#  firstname              :string
#  lastname               :string
#  cellphone              :string
#  zipcode                :string
#  address                :string
#  company                :string
#  company_address        :string
#  job_title              :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  image                  :string
#  tokens                 :json
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it "should be able to create a user with a email, identity, password, password_confirmation" do
    expect { @created_user = FactoryGirl.create(:user) }.to change(described_class, :count).by(1)
    expect(described_class.all).to include(@created_user)
  end

  describe "validations" do
    it "should be valid with a email, identity, password, password_confirmation" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    context "errors" do
      let(:user) { described_class.new(params) }

      before do
        user.valid?
      end

      context "email" do
        subject { user.errors.messages[:email] }

        context "should be invalid if email not provided" do
          let(:params) { { email: "" } }
          it { expect(subject).to include(I18n.t("errors.messages.blank")) }
        end

        context "should be invalid if email already been registered" do
          let(:email) { Faker::Internet.email }
          let(:params) { { email: email } }
          before do
            FactoryGirl.create(:user, email: email)
            user.valid?
          end

          it { expect(subject).to include(I18n.t("errors.messages.already_in_use"))  }
        end
      end

      context "identity" do
        subject { user.errors.messages[:identity] }
        context "should be invalid if identity not provided" do
          let(:params) { { identity: "" } }
          it { expect(subject).to include(I18n.t("errors.messages.blank")) }
        end

        context "should be invalid if identity already been registered" do
          let(:identity) { Faker::Internet.user_name }
          let(:params) { { identity: identity } }
          before do
            FactoryGirl.create(:user, identity: identity)
            user.valid?
          end

          it { expect(subject).to include(I18n.t("errors.messages.taken")) }
        end
      end
    end
  end
end
