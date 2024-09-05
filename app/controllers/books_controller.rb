class BooksController < ApplicationController
    def index
        @books=Book.limit(params[:limit]).offset(params[:offset])
        render json: BooksRepresenter.new(@books).as_json
    end

    def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))
        if book.save
            render json: {message: "Book Successfully Created", book: book}, status: 201
        else
            render json: book.errors , status: :unprocessable_entity
        end    
    end

    def destroy
        Book.find(params[:id]).destroy!
        head :no_content
    end

    def show
        @book = Book.find(params[:id])
        render json: @book , status: :ok
    end

    private

    def author_params
        params.require(:author).permit(:first_name, :last_name,:age)
    end

    def book_params
    params.require(:book).permit(:title, :author)
    end
end
