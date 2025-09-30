class BooksController < ApplicationController

  # 一覧画面
  def index
    # すべての投稿を取得
    @books = Book.all
    # 新規投稿用の空のインスタンスを作成
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
      # 保存が成功した場合、詳細画面へリダイレクトし、成功メッセージを表示
      redirect_to book_path(@book), notice: 'Book was successfully created.'
    else
      # 保存が失敗した場合、一覧画面を再描画
      # @books を再度設定しないと、一覧が表示されなくなる
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
      # 更新が成功した場合、詳細画面へリダイレクトし、成功メッセージを表示
      redirect_to book_path(@book), notice: 'Book was successfully updated.'
    else
      # 更新が失敗した場合、編集画面を再描画
      render :edit
    end
  end

  # 削除処理
  def destroy
    book = Book.find(params[:id])
    book.destroy
    # 削除後、一覧画面へリダイレクトし、成功メッセージを表示
    redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private
  # ストロングパラメータ：セキュリティのため、許可されたパラメータのみを受け取る
  def book_params
    params.require(:book).permit(:title, :body)
  end
end