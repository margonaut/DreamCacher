require 'rails_helper'

describe DreamsKeyword do
  it { should belong_to(:dream) }
  it { should belong_to(:keyword) }

  it { should validate_presence_of(:dream) }
  it { should validate_presence_of(:keyword) }

  it { should validate_presence_of(:sentiment) }
  it { should validate_numericality_of(:sentiment) }
  it { should have_valid(:sentiment).when('0.089', '1', '-1', '-0.89') }
  it { should_not have_valid(:sentiment).when('What', '1.1', '-1.5') }

  it { should validate_presence_of(:relevance) }
  it { should validate_numericality_of(:relevance) }
  it { should have_valid(:relevance).when('0.089', '1', '-1', '-0.89') }
  it { should_not have_valid(:relevance).when('What', '1.1', '-1.5') }

end
