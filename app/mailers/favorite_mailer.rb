class FavoriteMailer < ApplicationMailer
  default from: "youremail@email.com"

  def new_comment(user, post, comment)

    headers["Message-ID"] = "<comments/#{comment.id}@salty-refuge-91119.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@salty-refuge-91119.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@salty-refuge-91119.herokuapp.com>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "You have a new comment on #{post.title}.")
  end

  def new_post(post)
    headers["Message-ID"] = "<posts/#{post.id}@salty-refuge-91119.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{post.id}@salty-refuge-91119.herokuapp.com>"
    headers["References"] = "<post/#{post.id}@salty-refuge-91119.herokuapp.com>"

    @post = post

    mail(to: post.user.email, subject: "You're following, #{post.title}!")
  end
end
