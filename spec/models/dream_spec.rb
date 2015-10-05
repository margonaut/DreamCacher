require 'rails_helper'

describe Dream do
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:sentiment) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:user) }
end
