# frozen_string_literal: true

class PostsController < PagesController
  before_action :authenticate_user!, except: [:index, :tag, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  after_action(only: [:index, :tag]) { create_show_impressions(@posts) }
  after_action(only: :show) { create_visit_impression(@post)  }
  after_action(only: [:create, :update]) { notify_slack(@post, action_name) }

  def index
    @popular = Post.published.desc.take(5)
    @posts = Post.includes(:user).published.desc.page(params[:page])
    @top, @left, @right = Partner.side
    respond_to do |format|
      format.html
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def tag
    @popular = Comment.popular
    @posts = Post.includes(:user)
                 .published.desc.tagged_with(params[:tag])
                 .page(params[:page])
    @top, @left, @right = Partner.side
    respond_to do |format|
      format.html { render :index }
      format.js { render partial: "shared/index", locals: { records: @posts } }
    end
  end

  def new
    @post = Post.new
    @top = Partner.side(1)
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      @post.karmas.create(user: current_user,
                          giver: current_user,
                          kind: "created")
      redirect_to @post, notice: I18n.t(:p_created)
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @popular = Comment.popular
    @top, @right = Partner.side
    @inline = Partner.inline(1, { tags: @post.tag_list })
  end

  def edit
    @top = Partner.side(1)
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: I18n.t(:p_updated)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: I18n.t(:p_destroyed)
  end

  def upvote
    @record = Post.find(params[:id])
    @record.upvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.create(user: @record.user,
                          giver: current_user,
                          kind: "upvoted")
    render "shared/votes/upvote.js.erb"
  end

  def downvote
    @record = Post.find(params[:id])
    @record.unvote_by current_user if current_user.voted_for? @record
    @record.downvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/downvote.js.erb"
  end

  def unvote
    @record = Post.find(params[:id])
    @record.unvote_by current_user
    @record.update_attribute(:votes_count, @record.score)
    @record.karmas.where(user: @record.user,
                         giver: current_user,
                         kind: "upvoted").destroy_all
    render "shared/votes/unvote.js.erb"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :published_at, tag_list: [])
  end

  def set_post
    @post = Post.find(params[:id])
    @post = nil unless current_user.try(:can_edit?, @post)
  end
end
