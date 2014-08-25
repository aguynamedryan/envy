require "spec_helper"
require "rails"
require "envy/rails"

describe Envy::Railtie do
  let(:envfile) { fixture_path("Envfile") }
  let(:application) { Class.new(Rails::Application) }

  before do
    @env = ENV.to_h
    Rails.application = nil
    ENV["ENVFILE"] = envfile
  end

  after do
    ENV.update @env
    Envy.env = nil
  end

  it "defines #env on the application" do
    expect(application.env).to be(Envy.env)
  end

  it "evalates the Envfile" do
    expect(application.env).to respond_to(:from_envfile)
  end
end
