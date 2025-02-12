require 'csv'

# Takes in users, posts, or some other model
# Takes in a list of headers
# Takes in a path to where the report should be generated
def generate_report(records, headers, report_path)
  CSV.open(report_path, 'wb') do |csv|
    csv << headers

    records.each do |record|
      csv << yield(record)
    end
  end

  p "Report generated: #{report_path}"
end

namespace :reports do
  # rails reports:user_signups
  desc 'Generate user signups report for the past week'
  task :user_signups => :environment do
    start_date = Time.current.beginning_of_month
    end_date = Time.current.end_of_month

    signups = User.where(created_at: start_date..end_date)
    headers = ['User.ID', 'Email', 'Signup Date']
    report_path = Rails.root.join('tmp', 'user_signups_report.csv')

    generate_report(signups, headers, report_path) do |user|
      [user.id, user.email, user.created_at]
    end

  end

  desc 'Generate average views per day report for this month'
  task :average_views_per_day => :environment do
    start_date = Time.current.beginning_of_month
    end_date = Time.current.end_of_month

    records = (start_date.to_date..end_date.to_date).map do |date|
      average_views = Post.where(created_at: date.beginning_of_day..date.end_of_day).average(:views)
      [date, average_views.to_f.round(2)]
    end
    headers = ['Date', 'Average Views']
    report_path = Rails.root.join('tmp', 'average_views_per_day_report.csv')


    generate_report(records, headers, report_path) { |record| record }
    
    end
end
