require 'rails_helper'

describe Keyword do
  it { should have_many(:dreams_keywords) }
  it { should validate_presence_of(:text) }

  it { should validate_uniqueness_of(:text) }

end
