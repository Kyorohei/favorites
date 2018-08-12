class BlogsController < ApplicationController
before_action :set_blog, only: [:edit, :update, :destroy]
before_action :user_logged_in?, only: [:new, :edit, :show, :destroy]

  def index
    @blogs = Blog.all
  end
  
  def show
    @blog = Blog.find(params[:id])
  end
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: "つぶやき完了"
    else
      render 'new'
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])   
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集完了！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"削除完了!"
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  def user_logged_in?
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    else
      flash[:notice] = "利用にはログインが必要です"
    redirect_to new_session_path
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:content)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end

end
