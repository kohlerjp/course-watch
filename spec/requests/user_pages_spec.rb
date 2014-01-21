require 'spec_helper'
  describe 'User pages' do
      
    subject { page }
    describe "Signup" do
      before { visit signup_path }

      it { should have_content('Sign up') }
      it { should have_title("Course Watch | Signup") }
    end

    describe 'Profile page' do
      let(:user) { FactoryGirl.create(:user) }
      before {visit user_path(user)}
      it {should have_content(user.first_name)}
      it {should have_title(user.first_name)}
    end

    describe 'Signup' do
      before { visit signup_path}
      let(:submit) {"Create my account"}
      describe 'with invalid information' do
        it 'should not create a user do' do
          expect {click_button submit}.not_to change(User,:count)
        end
      end
      describe 'with valid information' do
        before do
          fill_in 'First Name', with: "John"
          fill_in 'Last Name', with: "Kohler"
          fill_in 'Email', with: "kohler.j@husky.neu.edu"
          fill_in 'Password', with: "testing"
          fill_in 'Confirm Password', with: "testing"

          it "Shold create a user" do
            expect{click_button submit}.to change(User, :count).by(1)
          end
        end
      end
    end
      
end