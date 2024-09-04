require 'rails_helper'

RSpec.describe Author, type: :model do
  describe  "Validate Book" do
    it "Require the presence of first name" do 
      expect(Author.new).not_to be_valid
    end
  end  

  describe "Author Association Has_many" do 
    before do 
      Book.destroy_all
      Author.destroy_all
    end
    let!(:author){ Author.create(first_name:"akansha", last_name:"mittal", age:18)}
    it "has_many Association" do 
      worker1 = Book.create(title:"qwe")
      worker2= Book.create(title:"qww")
      author.books <<[worker1,worker2]
      expect(author.books.first).to eq(worker1)
      expect(author.books.second).to eq(worker2)
      expect(Author.count).to eq(1)
    end
  end

  describe "belongs_to association" do 
    let!(:author){ Author.create(first_name:"akk",last_name:"a", age:11)}
    let!(:book1){FactoryBot.create(:book, title:"q1",author:author)}
    let!(:book2){FactoryBot.create(:book, title:"q2", author: author)}
    it "belongs_to" do 
      expect(book1.author).to eq(author)
      expect(book2.author).to eq(author)
      expect(Author.count).to eq(1)
    end
  end
end
