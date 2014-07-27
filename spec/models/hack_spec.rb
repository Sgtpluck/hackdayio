# == Schema Information
#
# Table name: hacks
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  votes              :integer          default(0)
#  url                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  presentation_index :integer
#  upvoted_by         :text             default("--- []\n")
#  downvoted_by       :text             default("--- []\n")
#  hackday_id         :integer
#

require 'spec_helper'

describe Hack do
  before do
    @hack = Fabricate(:hack)
  end

  it 'should be valid' do
    expect(@hack).to be_valid
  end

  it "should require a title" do
    @hack.title = nil

    expect(@hack).to_not be_valid
  end

  it "should require a description" do
    @hack.title = nil

    expect(@hack).to_not be_valid
  end

  it "should handle voting with dignity and grace"

end
