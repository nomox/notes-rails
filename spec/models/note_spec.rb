require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }

    it do
      should validate_length_of(:title).is_at_least(3)
                                       .is_at_most(120)
    end
  end
end
