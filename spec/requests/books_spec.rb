require 'rails_helper'

describe "Books API" , type: :request do
  before(:each) do
    Book.destroy_all
    Author.destroy_all
    author=  FactoryBot.create(:author , first_name:"akansha", last_name:"mittal",age:10)
    @book1= FactoryBot.create(:book, title: "as", author_id: author.id )
    @book2= FactoryBot.create(:book, title: "name", author_id: author.id)
  end

  describe " Get /books" do 
    it 'return all books' do
      get '/books'
      expect(response).to have_http_status(:success)
      expect((response_request).size).to eq(2)
      expect(response_request).to eq(
        [
          {
            "id" => @book1.id,
            "title" => "as",
            "author_name"=> "akansha mittal" ,
            "age"=> 10
          },
          {
            "id"=> @book2.id,
            "title"=> "name",
            "author_name"=>"akansha mittal" ,
            "age"=> 10
          }
        ]
      )
    end
  end

  describe "Get /books/:id" do 
    it "show the particular book" do 
       get "/books/#{@book1.id}"
       expect(response).to have_http_status(:success)
    end
  end

  # without association we write this -->
  # describe "Post /books" do 
  #   it 'create the book' do
  #     expect {
  #     post "/books" , params: {book: {title: "ABC"}}
  #     }.to change {Book.count}.from(0).to(1)

  #     expect(response). to have_http_status(:created)
  #   end
  # end


  describe "book for association" do 
    before(:each) do
      Book.destroy_all
      Author.destroy_all
    end
    it "create a book" do 
      expect {
      post "/books" , params: {
        book: {title:"akansha"},
        author: {first_name: "A", last_name:"B",age:48}
      }
    }.to change{Book.count}.from(0).to(1)

    expect(response).to have_http_status(:created)
    end
  end

  describe "Delete /books/:id" do

    it 'delete the book' do
      expect{
        delete "/books/#{@book1.id}"
      }.to change{Book.count}.from(2).to(1)

       expect(response).to have_http_status(:no_content)
       expect(Book.exists?(@book1.id)).to be(false)
    end
  end

  describe "check" do 
    it "A" do
      expect(Book.exists?(@book1.id)).to be(true)
    end

    it "B" do
      expect(@book1.title).to eq("as")
    end 
  end
end