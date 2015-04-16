require 'spec_helper'

RSpec.describe Settings, type: :model do
	subject { Settings }
	it { expect(subject.machine_name).not_to be_nil }
end
