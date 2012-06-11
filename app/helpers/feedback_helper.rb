module FeedbackHelper
  def feedback_widget
    if %w(production development).include? Rails.env
      render partial: 'shared/feedback_widget'
    end
  end
end
