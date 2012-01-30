require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", uid: "12345") }

  subject { @user }

  it { should respond_to(:name) }
end
