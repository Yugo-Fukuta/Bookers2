class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.page(params[:page]).reverse_order
    @book = Book.new
    @user = current_user
  end
  def new

  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.page(params[:page]).reverse_order
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end
  def show
    @detailed_book = Book.find(params[:id])
    @book = Book.new
    @user = @detailed_book.user
  end
  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:alert] = "権限がありません"
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
