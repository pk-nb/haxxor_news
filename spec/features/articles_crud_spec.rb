require 'spec_helper'

RSpec.describe 'Articles CRUD' do

  describe '#index' do
    it 'displays nothing with no articles in database' do
      visit '/'
      page.should_not have_css('.article')
    end

    it 'displays all articles in database' do
      FactoryGirl.create(:article, title: 'Article 1')
      FactoryGirl.create(:article, title: 'Article 2')

      visit '/'

      page.should have_content 'Article 1'
      page.should have_content 'Article 2'
    end
  end

  describe '#create' do
    before do
      visit '/'
      click_on 'New Article'
    end

    it 'displays an error when not filled' do
      click_on 'Create Article'

      page.should have_content 'Article was not posted'
    end

    it 'succeeds when submitting with valid input' do
      fill_in 'Title', with: 'Coolest blog ever'
      fill_in 'URL', with: 'http://pk-nb.github.io'

      expect {
        click_on 'Create Article'
      }.to change {
        Article.count
      }.from(0).to(1)

      page.should have_content 'Coolest blog ever'
    end
  end

end
