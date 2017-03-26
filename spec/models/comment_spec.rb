require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_valid(:body).when("Omg this is great", "Love your writing") }
end
