require 'rails_helper'

describe DreamSerializer do
  context 'Serializing a single dream' do
    let(:dream) { FactoryGirl.build(:dream) }
    let(:serializer) { DreamSerializer.new(dream) }
    let(:serialized_json) { JSON.parse(serializer.to_json) }
    let(:attributes) { dream_attributes(dream) }

    it 'has the dreams users email' do
      expect(serialized_json['dream']['user_email']).to eql(attributes[:user_email])
    end

    it 'has a true or false mixed value' do
      expect(serialized_json['dream']['mixed']).to eql(attributes[:mixed])
    end
  end
end

def dream_attributes(dream)
  {
    user_email: dream.user.email,
    mixed: false
  }
end
