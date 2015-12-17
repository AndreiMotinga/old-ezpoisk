require 'rails_helper'

describe Picture do
  it { should belong_to(:imageable) }
end
