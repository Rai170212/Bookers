class BooksController < ApplicationController

  # 投稿一覧画面 (アプリケーショントップ画面)
  def index
    # IDの若い順に一覧表示
    @books = Book.all.order(id: :asc) 
    # 新規投稿フォーム用のインスタンス
    @book = Book.new 
  end

  # 投稿詳細画面
  def show
    @book = Book.find(params[:id])
  end

  # 新規投稿処理
  def create
    @book = Book.new(book_params)
    if @book.save
      # 処理成功: サクセスメッセージを設定し、詳細画面へリダイレクト
      flash[:notice] = "Book was successfully created." 
      redirect_to book_path(@book)
    else
      # 処理失敗: エラーメッセージを表示するため、indexを再描画
      @books = Book.all.order(id: :asc) 
      render :index, status: :unprocessable_entity 
    end
  end

  # 投稿編集画面
  def edit
    @book = Book.find(params[:id])
  end

  # 更新処理
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # 処理成功: サクセスメッセージを設定し、詳細画面へリダイレクト
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      # 処理失敗: エラーメッセージを表示するため、editを再描画
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除処理
  def destroy
    book = Book.find(params[:id])
    book.destroy
    # 処理成功: サクセスメッセージを設定し、一覧画面へリダイレクト
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path, status: :see_other
  end

  private
    # ストロングパラメータ
    def book_params
      params.require(:book).permit(:title, :body)
    end
end