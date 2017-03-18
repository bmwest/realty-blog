require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should have_valid(:title).when("Next Open House") }
  it { should_not have_valid(:title).when(nil, "") }

  it { should have_valid(:body).when("Our next open house will be
                                      in a lovely colonial Chestnut Hill
                                      mansion. To attend, please RSVP at:
                                      267-555-5555 by no later than Wednesday,
                                      April 3, 2017. Hope to see you there!") }
  it { should_not have_valid(:body).when(nil, "") }
end
