require 'spec_helper'

describe Quest do
  subject { Factory.build(:quest) }
  it { should belong_to(:quest_definition) }
  it { should belong_to(:user)             }
  it { should have_many(:quest_objectives) }
end
