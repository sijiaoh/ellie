module PostsHelper
  def posts_link
    button_link_primary t("posts.index.title"), posts_path if policy(:post).index?
  end

  def back_to_posts_link
    button_link_secondary t("back_to_index"), posts_path if policy(:post).index?
  end

  def post_link(post)
    button_link_primary t("detail"), post if policy(post).show?
  end

  def new_post_link
    button_link_primary t("posts.new.title"), new_post_path if policy(:post).new?
  end

  def edit_post_link(post)
    button_link_primary t("edit"), [:edit, post] if policy(post).edit?
  end

  def destroy_post_button(post)
    return unless policy(post).destroy?

    button_danger(
      t("destroy"),
      post,
      method: :delete,
      form: { data: { turbo_confirm: t("destroy_confirm") } }
    )
  end
end
