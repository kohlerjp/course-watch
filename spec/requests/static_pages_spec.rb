require 'spec_helper'
  describe 'Static pages' do
      
    subject { page }
    describe "Home page" do
      before { visit root_path }

      it { should have_content('Course Watch') }
      it { should have_title("Course Watch | Home") }
    end
  end

