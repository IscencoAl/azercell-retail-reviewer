require 'rails_helper'

RSpec.describe UserRole, :type => :model do

  it 'should have predefined values' do
    user_roles = UserRole.all.map{ |ur| ur.name }.to_set

    expect(user_roles).to be_eql Set.new(['admin', 'user'])
  end

end
