shared_examples_for "all static pages" do
	it { should have_selector('h1', text: heading) }
	it { should have_title(full_title(page_title)) }
end

shared_examples_for "activity associations" do |model, activity|
	describe "#{activity} associations" do
		let!(:user) { FactoryGirl.create(:user) }
		let!(:this_activity) { FactoryGirl.create(activity.to_sym, user: user) }

		describe "on user destroy" do
			before { user.destroy }

			it "destroys assoc #{activity}" do
				expect(model.where(id: this_activity.id)).to be_empty
			end
		end
	end
end

shared_examples_for "!signed_in? quantifiers controller" do |quantifier|
	describe "in #{quantifier.capitalize.pluralize} controller" do
		describe "new #{quantifier} GET /#{quantifier.pluralize}/new" do
			new_quantifier_path = "new_#{quantifier}_path".to_sym
			before { visit send(new_quantifier_path) }
			it { should have_title('Sign In') }
		end

		describe "create #{quantifier} POST /#{quantifier.pluralize}" do
			create_quantifier_path = "#{quantifier.pluralize}_path".to_sym
			before { post send(create_quantifier_path) }
			specify { expect(response).to redirect_to(signin_path) }
		end
	end
end

shared_examples_for "!signed_in? activity controller" do |activity|
	describe "in #{activity.capitalize.pluralize} controller" do
		describe "new #{activity} GET /#{activity.pluralize}/new" do
			new_activity_path = "new_#{activity}_path".to_sym
			before { visit send(new_activity_path) }
			it { should have_title('Sign In') }
		end

		describe "create #{activity} POST /#{activity.pluralize}" do
			create_activity_path = "#{activity.pluralize}_path".to_sym
			before { post send(create_activity_path) }
			specify { expect(response).to redirect_to(signin_path) }
		end

		describe "show #{activity} GET /#{activity.pluralize}/:id" do
			let!(:this_activity) { FactoryGirl.create(activity.to_sym) }
			show_activity_path = "#{activity}_path".to_sym
			before { visit send(show_activity_path, this_activity) }
			it { should have_title('Sign In') }
		end		
	end
end

shared_examples_for "wrong_user activity#show" do |activity|
	describe "in #{activity.capitalize.pluralize} controller" do
	  describe "show page GET /#{activity.pluralize}/:id" do
	    let!(:wrong_users_activity) { FactoryGirl.create(activity.to_sym, user: wrong_user) }
	    this_path = "#{activity}_path".to_sym
	    before { get send(this_path, wrong_users_activity) }
	    specify { expect(response.body).to redirect_to(root_url) }
	  end
	end
end

shared_examples_for "#admin? activity#show" do |activity|
	describe "in #{activity.capitalize.pluralize} controller" do
	  describe "show page GET /#{activity.pluralize}/:id" do
	    let!(:this_activity) { FactoryGirl.create(activity.to_sym, user: user) }
	    this_path = "#{activity}_path".to_sym
	    before { get send(this_path, this_activity) }
	    specify { expect(response.body).to match(this_activity.title) }
	  end
	end
end
