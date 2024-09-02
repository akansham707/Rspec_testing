require 'rails_helper'

describe "Books API" , type: :request do
  before(:each) do
    Book.destroy_all
  end

  describe " Get /books" do 
   
    it 'return all books' do
      FactoryBot.create(:book, title: "as" , author: "qwe")
      FactoryBot.create(:book, title: "name", author: "qq")
      get '/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "Post /books" do 
    it 'create the book' do
      expect {
      post "/books" , params: {book: {title: "ABC", author: "qwe"}}
      }.to change {Book.count}.from(0).to(1)

      expect(response). to have_http_status(:created)
    end
  end

  describe "Delete /books/:id" do
    let!(:book) {FactoryBot.create(:book, title: "as" , author: "qwe")}

    it 'delete the book' do
      expect{
        delete "/books/#{book.id}"
      }.to change{Book.count}.from(1).to(0)

       expect(response).to have_http_status(:no_content)
       expect(Book.exists?(book.id)).to be(false)
    end
  end

  describe "check" do 
    before(:each) do 
     @book= FactoryBot.create(:book, title:"as" , author:"asd")
    end

    after(:each) do 
      @book.destroy
    end

    it "A" do
      expect(Book.exists?(@book.id)).to be(true)
    end

    it "B" do
      expect(@book.title).to eq("as")
    end 
  end
end