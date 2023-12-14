class BlogPostsController < ApplicationController
  
  
  before_action :authenticate_user!, except: [:show, :index]
  
  before_action :set_blog_post, only:  [:show, :edit, :update, :destroy ]
  #ou
  #before_action :set_blog_post, exept: [:index, :new, :create,  ]
  
  
  
  
  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.published.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params) 
    if @blog_post.save
      redirect_to @blog_post
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def update
    # @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy  
    redirect_to root_path
  end

  def set_blog_post
    @blog_post = BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end
  end

  # def authenticate_user!
  #   redirect_to new_user_session_path, alert: "You must be signed in to continue" unless user_signed_in?
  # end

  private 

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
    
end