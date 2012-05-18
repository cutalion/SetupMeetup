namespace :setupmeetup do
  namespace cron: :environment do
    desc "Daily cron task. Send notifications a week before the event" do
      CronNotifier.send_weekly_notifications
    end
  end
end
