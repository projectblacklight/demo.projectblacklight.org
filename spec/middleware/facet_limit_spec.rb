require 'rails_helper'

RSpec.describe FacetLimit do
  let(:app) { ->(_env) { [200, {}, ['ok']] } }
  let(:middleware) { described_class.new(app, max_values: 4) }

  def get(query)
    Rack::MockRequest.new(middleware).get("/?#{query}")
  end

  def facets(count, key: 'f')
    Array.new(count) { |i| "#{key}%5Bsubject_ssim%5D%5B%5D=Subject+#{i}" }.join('&')
  end

  it 'allows requests without facets' do
    expect(get('q=history').status).to eq 200
  end

  it 'allows requests at the limit' do
    expect(get(facets(4)).status).to eq 200
  end

  it 'rejects requests over the limit' do
    response = get(facets(5))

    expect(response.status).to eq 400
    expect(response.body).to include 'Too many filters'
  end

  it 'counts values across facet fields and f_inclusive' do
    expect(get("#{facets(3)}&#{facets(2, key: 'f_inclusive')}").status).to eq 400
  end

  it 'passes malformed queries through to the app' do
    expect(get('f=string&f[x][]=1').status).to eq 200
  end

  it 'runs before Rails logging and sessions' do
    stack = Rails.application.middleware.map(&:klass)

    expect(stack.index(described_class)).to be < stack.index(Rails::Rack::Logger)
  end
end
