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

  describe 'articles are paginated' do
    context 'less than or equal to 20 articles' do
      before do
        FactoryGirl.create_list(:article, 20)
        visit '/'
      end

      it 'should not be paginated' do
        within('.page-numbers') { expect(page).to_not have_link('1') }
        within('.page-numbers') { expect(page).to_not have_link('2') }
      end
    end

    context 'more than 20 articles' do
      before do
        FactoryGirl.create_list(:article, 21)
        visit '/'
      end

      it 'should be paginated' do
        within('.page-numbers') { expect(page).to have_link('1') }
        within('.page-numbers') { expect(page).to have_link('2') }
      end
    end

    context 'article numbers' do
      before do
        FactoryGirl.create_list(:article, 41)
        visit '/'
      end

      it 'should have the correct offset' do
        within('.page-numbers') { click_on '2' }
        expect(page).to have_link('21')
        within('.page-numbers') { click_on '3' }
        expect(page).to have_link('41')
      end
    end

  end
end
