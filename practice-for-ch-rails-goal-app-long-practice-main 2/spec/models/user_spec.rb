require 'rails_helper'

RSpec.describe User, type: :model do

    it {should validate_presence_of (:username)}
    it {should validate_presence_of (:password)}
    it { should validate_length_of(:password).is_at_least(6)}


    
    describe 'uniqueness' do
        before :each do
            FactoryBot.create(:user)
        end

        it {should validate_uniqueness_of(:username)}
        it {should validate_uniqueness_of(:session_token)}

    end

    describe "is_password?" do
        let(:user) { FactoryBot.create(:user, password: '123456')}

        context "with a valid password" do
            it "should return true" do
                expect(user.is_password?("123456")).to be true
            end
        end


        context "with an invalid password" do
            it "should return false" do
                expect(user.is_password?("bananaman")).to be false
            end
        end


        describe 'password encryption' do
            it 'does not save the password to the database' do
                FactoryBot.create(:user, username: 'Harry Potter')

                user = User.find_by(username: 'Harry Potter')
                expect(user.password).not_to eq('password')
            end
        end


    end

end