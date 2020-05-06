class BooksController < ApplicationController

 before_action :authenticate_user!

  def show
    @newbook = Book.new
  	@book = Book.find(params[:id])
    @book_comments = BookComment.new
  end

  def index
    @book = Book.new
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params)
    @books = Book.all
    @book.user_id = current_user.id #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      flash[:error_messages] = @book.errors.full_messages
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    unless @user == current_user
           redirect_to books_path
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else
    #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
      flash[:error_messages] = @book.errors.full_messages
      render "edit"

  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
