module ApplicationHelper
    include DateHelper
    def user_voted?(poll, user)
        user && Vote.exists?(poll_id: poll.id, user_id: user.id)
    end

    def poll_expired?(poll)
        poll.expires_at.present? && poll.expires_at < Time.current
    end
end
