require 'rails_helper'

RSpec.describe 'Integration test' do
  it 'works' do
    visit '/'

    expect(page).to have_content 'Blacklight'
  end
end
