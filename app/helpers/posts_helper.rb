module PostsHelper
  def posts_btn_link
    btn_to t("posts.index.title"), posts_path, type: :link if policy(:post).index?
  end

  def back_to_posts_btn_link
    btn_to t("back_to_index"), posts_path, type: :link, color: :secondary if policy(:post).index?
  end

  def post_btn_link(post)
    btn_to t("detail"), post, type: :link if policy(post).show?
  end

  def new_post_btn_link
    btn_to t("posts.new.title"), new_post_path, type: :link if policy(:post).new?
  end

  def edit_post_btn_link(post)
    btn_to t("edit"), [:edit, post], type: :link if policy(post).edit?
  end

  def destroy_post_button(post)
    return unless policy(post).destroy?

    btn_to(
      t("destroy"),
      post,
      method: :delete,
      form: { data: { turbo_confirm: t("destroy_confirm") } },
      color: :danger
    )
  end
end
