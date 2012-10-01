class CommentsController < ApplicationController

  ATTENDEES_ONLY = 'Only attendees can leave comments'
  EVENT_OR_COMMENT_OWNER_ONLY = 'Only event and comment owners can delete comments'
  COMMENT_NOT_FOUND = 'Comment not found'

  before_filter :authenticate_user!

  # creates the comment
  def create
    unless current_user.participated?(event)
      redirect_to event, alert: ATTENDEES_ONLY
      return
    end

    @comment = event.comments.build(params[:comment])
    @comment.owner = current_user
    @comment.save

    redirect_to event
  end

  # deletes the comment
  def destroy
    event = comment.event

    if comment.owner == current_user || event.owner == current_user
      comment.destroy
    else
      flash.alert = EVENT_OR_COMMENT_OWNER_ONLY
    end

    redirect_to event
  rescue Mongoid::Errors::DocumentNotFound
    redirect_to :root, alert: COMMENT_NOT_FOUND
  end

  private

  def comment
    @comment ||= Comment.find(params[:id])
  end

  def event
    @event ||= Event.find(params[:event_id])
  end

end
