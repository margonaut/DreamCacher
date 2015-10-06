require 'rails_helper'

describe Dream do
  it { should belong_to(:user) }

  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:sentiment) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:user) }

  it { should validate_length_of(:text).is_at_least(15) }

  it { should validate_length_of(:title).is_at_most(40) }
  it { should have_valid(:title).when('') }
  it { should have_valid(:title).when('Weird Dream #1') }

  it { should validate_numericality_of(:sentiment) }
  it { should have_valid(:sentiment).when('0.089', '-0.089', '1', '-1') }
  it { should_not have_valid(:sentiment).when('What', '1.1', '-5') }

  it { should have_valid(:date).when('1991-01-27') }
end
