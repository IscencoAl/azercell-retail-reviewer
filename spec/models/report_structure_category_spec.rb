require 'rails_helper'
require 'modules/soft_delete_spec'

RSpec.describe ReportStructureCategory, :type => :model do

  it_behaves_like "soft deletable", :dealer, Dealer

end
