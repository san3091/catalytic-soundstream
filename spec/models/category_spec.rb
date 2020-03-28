require 'rails_helper'
require 'faker'

RSpec.describe Category, type: :model do
  before :each do
    @file = fixture_file_upload('files/history.csv', 'text/csv')
    @category = Category.create(name: Faker::Name.name)
  end

  it 'populates the database from a csv file' do
    @category.import_albums(@file)
    expect(@category.albums).not_to be_empty
  end
end
