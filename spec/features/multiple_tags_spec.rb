feature 'adding multiple tags' do
  scenario '/links/new' do
    visit '/links/new'
    fill_in('url', with: 'http://www.makersacademy.com')
    fill_in('title', with: 'Makers Academy')
    fill_in('tag', with: 'education ruby')

    click_button 'Save'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education', 'ruby')
  end
end
