require 'spec_helper'

RSpec.describe 'Articles CRUD' do

  describe 'a user on the front page of articles' do
    it 'displays nothing with no articles in database' do
      visit '/'
      expect(page).to_not have_css('.article')
    end

    it 'displays all articles in database' do
      FactoryGirl.create(:article, title: 'Article 1')
      FactoryGirl.create(:article, title: 'Article 2')

      visit '/'

      expect(page).to have_content 'Article 1'
      expect(page).to have_content 'Article 2'
    end
  end

  describe 'a user creating a new article' do
    before do
      visit '/'
      click_on 'New Article'
    end

    let (:error_message) { 'Article was not posted' }

    it 'displays an error when not filled' do
      click_on 'Create Article'
      within('#flash') { expect(page).to have_content(error_message) }
    end

    it 'succeeds when submitting with valid input' do
      fill_in 'Title', with: 'Coolest blog ever'
      fill_in 'URL', with: 'http://pk-nb.github.io'

      expect {
        click_on 'Create Article'
      }.to change {
        Article.count
      }.by(1)

      expect(page).to have_content 'Coolest blog ever'
    end
  end

end
