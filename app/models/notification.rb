class Notification < ApplicationRecord
  
  default_scope->{order(created_at: :desc)}
  
  belongs_to :idea, optional: true
  belongs_to :comment, optional: true
  belongs_to :chat, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    #your_idea = link_to 'あなたの投稿', idea_path(notification), style:"font-weight: bold;"
     #@visitor_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        @visitor.name+"があなたをフォローしました"
      when "favorite" then
        @visitor.name+"が"+notification.idea.title+"にいいねしました"
      when "comment" then
        @visitor.name+"が"+notification.idea.title+"にコメントしました"
      when 'chat' then
        @visitor.name+'がチャットを送信しました'
    end
  end

end
