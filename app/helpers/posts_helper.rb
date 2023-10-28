module PostsHelper
  def posts_btn_link
    index_lnk_to(Post, type: :button)
  end

  def back_to_posts_btn_link
    back_to_index_lnk_to(Post, type: :button)
  end

  def post_btn_link(post)
    show_lnk_to(post, type: :button)
  end

  def new_post_btn_link
    new_lnk_to(Post, type: :button)
  end

  def edit_post_btn_link(post)
    edit_lnk_to(post, type: :button)
  end

  def destroy_post_button(post)
    destroy_btn_to(post)
  end
end
