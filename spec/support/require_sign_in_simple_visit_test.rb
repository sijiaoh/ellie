shared_examples "require sign in simple visit test" do
  context "when signed in" do
    include_context "when signed in"
    include_examples "simple visit test"
  end

  context "when not signed in" do
    it "redirects to sign in page" do
      visit path
      expect(page).to have_current_path sign_in_path
    end
  end
end
