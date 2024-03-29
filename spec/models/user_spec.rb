require 'spec_helper'

describe User do
  before {@user = User.new(first_name:"John",last_name:"Kohler",email:"kohler.j@husky.neu.edu",
                            password:"testing",password_confirmation:"testing")}

  subject{ @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}

  it { should be_valid}

  describe 'When first name is not present' do
    before { @user.first_name = " "}
    it { should_not be_valid}
  end 
  describe 'When last name is not present' do
    before { @user.last_name = " "}
    it { should_not be_valid}
  end 
  describe 'When email is not present' do
    before { @user.email = " "}
    it { should_not be_valid}
  end 
  describe 'When first name is too long' do
    before { @user.first_name = ("a" * 21)}
    it { should_not be_valid}
  end
  describe 'When last name is too long' do
    before { @user.last_name = ("a" * 21)}
    it { should_not be_valid}
  end
  describe 'When email is too long' do
    before { @user.email = ("a" * 31)}
    it { should_not be_valid}
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com john@yahoo.com steve@harvard.neu.edu carl@husky.neu.edu.edu]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[jkohler@husky.neu.edu JKOHLER@husKY.Neu.EDU kohler.j@husky.neu.edu]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken insensitive" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "When password is not present" do
    before do
      @user = User.new(first_name:"Test", last_name:"test", email: "kohler.j@husky.neu.edu",
                        password: " ",password_confirmation:" ")
    end
    it {should_not be_valid}
  end  


  describe "When passwords do not match" do
    before do
      @user.password_confirmation = "mismatch"
    end
    it {should_not be_valid}
  end

  describe "Return value of authenticate method" do
    before do
     @user.save
    end
    let(:found_user) {User.find_by(email: @user.email)}

    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
    end

    describe "with valid password" do
      before do
        @user.password= "a" * 5
      end
      it {should_not be_valid}
    end


  end



end
