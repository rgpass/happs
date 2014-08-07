require 'spec_helper'

describe User do
  before { @user = User.new(first_name: "Ben", last_name: "Dover",
  													email: "ben.dover@gmail.com",
  													password: "foobar",
  													password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:subjective_happiness_scales) }

  it { should be_valid }
  it { should_not be_admin }

  describe "when admin set to 'true'" do
  	before do
  		@user.save!
  		@user.toggle!(:admin)
  	end

  	it { should be_admin }
  end

  describe "first name" do
	  describe "not present" do
	  	before { @user.first_name = " " }
	  	it { should_not be_valid }
	  end

	  describe "too long" do
	  	before { @user.first_name = "a" * 21 }
	  	it { should_not be_valid }
	  end
  end

  describe "last name" do
	  describe "not present" do
	  	before { @user.last_name = " " }
	  	it { should_not be_valid }
	  end

	  describe "too long" do
	  	before { @user.last_name = "a" * 31 }
	  	it { should_not be_valid }
	  end
  end

	describe "email" do
		describe "format is incorrect" do
	    it "is invalid" do
	      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
	      addresses.each do |invalid_address|
	        @user.email = invalid_address
	        expect(@user).not_to be_valid
	      end
	    end
	  end

	  describe "format is correct" do
	    it "is valid" do
	      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
	      addresses.each do |valid_address|
	        @user.email = valid_address
	        expect(@user).to be_valid
	      end
	    end
	  end

	  describe "mixed case" do
	  	let(:mixed_case_email) { "fooBAR@exaMpLE.com" }

	  	it "is saved as lowercase" do
	  		@user.email = mixed_case_email
	  		@user.save
	  		expect(@user.reload.email).to eq mixed_case_email.downcase
	  	end
	  end

	  describe "when already taken" do
	  	before do
	      user_with_same_email = @user.dup
	      user_with_same_email.save
	    end

	    it { should_not be_valid }
	  end
	end

	describe "password" do
		describe "not present" do
			before { @user.password = " " }
			before { @user.password_confirmation = " " }

			it { should_not be_valid }
		end

		describe "doesn't match confirmation" do
			before { @user.password_confirmation = "mismatch" }

			it { should_not be_valid }
		end

		describe "too short" do
			before { @user.password = @user.password_confirmation = "a" * 5 }
			it { should be_invalid }
		end

		describe "return value of authenticate method" do
	    before { @user.save }
	    let(:found_user) { User.find_by(email: @user.email) }

	    describe "with valid password" do
	      it { should eq found_user.authenticate(@user.password) }
	    end

	    describe "with invalid password" do
	      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	      it { should_not eq user_for_invalid_password }
	      specify { expect(user_for_invalid_password).to be_false }
	    end
	  end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	describe ".new_remember_token" do
		let(:new_remember_token_1) { User.new_remember_token }
		let(:new_remember_token_2) { User.new_remember_token }

		it "returns 22 char string" do
			expect(User.new_remember_token).to be_a(String)
		end

		it "is random" do
			expect(new_remember_token_1).not_to eq(new_remember_token_2)
		end
	end

	describe ".digest" do
		let(:new_remember_token) { "KZXxHG8ZFEViTuDOC1Kzpg" }

		it "SHA1 hashes a string" do
			expected = expect(User.digest(new_remember_token))
			expected.to eq("4ff9c77c36cf560d3b31ca79b1a50f790dc1218e")
		end
	end

	describe "subjective_happiness_scale associations" do
		before { @user.save }
		let!(:older_shs) do
			FactoryGirl.create(:subjective_happiness_scale, user: @user,
				created_at: 1.day.ago)
		end
		let!(:newer_shs) do
			FactoryGirl.create(:subjective_happiness_scale, user: @user,
				created_at: 1.hour.ago)
		end

		it "correct order" do
			expect(@user.subjective_happiness_scales.to_a).to eq(
				[newer_shs, older_shs])
		end

		it "destroys associated SHSes" do
			subjective_happiness_scales = @user.subjective_happiness_scales.to_a
			@user.destroy
			expect(subjective_happiness_scales).not_to be_empty
			subjective_happiness_scales.each do |shs|
				expect(SubjectiveHappinessScale.where(id: shs.id)).to be_empty
			end
		end
	end

	describe "activity associations" do
		before { @user.save }
		let!(:older_activity) do
			FactoryGirl.create(:activity, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_activity) do
			FactoryGirl.create(:activity, user: @user, created_at: 1.day.ago)
		end

		it "correct order" do
			expect(@user.activities.to_a).to eq([newer_activity, older_activity])
		end

		describe "on user destroy" do
			it "destroys assoc activities" do
				activities = @user.activities.to_a
				@user.destroy
				expect(activities).not_to be_empty
				activities.each do |activity|
					expect(Activity.where(id: activity.id)).to be_empty
				end
			end
		end
	end

	describe "ohq associations" do
		before { @user = FactoryGirl.create(:user) }
		let!(:older_ohq) do
			FactoryGirl.create(:ohq, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_ohq) do
			FactoryGirl.create(:ohq, user: @user, created_at: 1.hour.ago)
		end

		it "correct order" do
			expect(@user.ohqs.to_a).to eq([newer_ohq, older_ohq])
		end

		describe "on user destroy" do
			it "destroys assoc ohqs" do
				ohqs = @user.ohqs.to_a
				@user.destroy
				expect(ohqs).not_to be_empty
				ohqs.each do |ohq|
					expect(Ohq.where(id: ohq.id)).to be_empty
				end
			end
		end
	end

	describe "pafd associations" do
		before { @user = FactoryGirl.create(:user) }
		let!(:pafd) { FactoryGirl.create(:pafd, user: @user) }

		describe "on user destroy" do
			before do
				@user.destroy
			end

			it "destroys assoc pafd" do
				expect(Pafd.where(id: pafd.id)).to be_empty
			end
		end
	end

	describe "gratitude associations" do
		before { @user = FactoryGirl.create(:user) }
		let!(:gratitude) { FactoryGirl.create(:gratitude, user: @user) }

		describe "on user destroy" do
			before { @user.destroy }

			it "destroys assoc gratitude" do
				expect(Gratitude.where(id: gratitude.id)).to be_empty
			end
		end
	end
end
