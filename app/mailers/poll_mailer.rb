class PollMailer < ApplicationMailer
  def poll_ended_email(poll, user)
    @poll = poll
    @user = user
    mail(to: user.email, subject: "Bình chọn '#{poll.title}' đã kết thúc")
  end
end
