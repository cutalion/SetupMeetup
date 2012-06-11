namespace :setupmeetup do
  namespace :cron do
    desc "Weekly cron task. Send notifications a week before the event" 
    task weekly_notifications: :environment do
      CronNotifier.send_weekly_notifications
    end
    desc "Today cron task. Send notifications a day before the event" 
    task today_notifications: :environment do
      CronNotifier.send_today_notifications
    end
  end
end
