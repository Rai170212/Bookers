class BooksController < ApplicationController

  # 一覧画面
  def index
    @books = Book.all
    @book = Book.new
  end

  # 詳細画面
  def show
    @book = Book.find(params[:id])
  end

  # 新規作成処理
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      @books = Book.all
      render :index
    end
  end

  # 編集画面
  def edit
    @book = Book.find(params[:id])
  end

  # 更新処理
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # 削除処理
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private
  # ストロングパラメータ：セキュリティのため、許可されたパラメータのみを受け取る
  def book_params
    params.require(:book).permit(:title, :body)
  end
end

