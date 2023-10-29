require "rails_helper"

describe Utils do
  describe ".env_or_secret" do
    subject(:returns) { Utils.env_or_secret key }

    let(:key) { "a.b_c" }
    let(:env_value) { "env_value" }
    let(:credentials_value) { "credentials_value" }

    shared_context "with env" do
      before do
        allow(ENV).to receive(:fetch).with("A__B_C", nil).and_return(env_value)
      end
    end

    shared_context "with credentials" do
      before do
        a = ActiveSupport::InheritableOptions.new(b_c: credentials_value)
        allow(Rails.application.secrets).to receive(:a).and_return(a)
      end
    end

    context "with env" do
      include_context "with env"

      it "returns env value" do
        expect(returns).to eq env_value
      end
    end

    context "with credentials" do
      include_context "with credentials"

      it "returns credentials value" do
        expect(returns).to eq credentials_value
      end
    end

    context "with env and credentials" do
      include_context "with env"
      include_context "with credentials"

      it "returns env value" do
        expect(returns).to eq env_value
      end
    end

    context "without anything" do
      it "raises error" do
        expect { returns }.to raise_error StandardError
      end
    end
  end
end
