require 'spec_helper'

describe Teammate do
  it { should have_valid(:account_id).when('1') }
  it { should_not have_valid(:account_id).when(nil,'') }

  it { should have_valid(:person_id).when('1') }
  it { should_not have_valid(:person_id).when(nil,'') }

  it { should belong_to :account }
  it { should belong_to :person }
end
