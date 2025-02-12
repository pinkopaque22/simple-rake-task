require 'csv'

# Takes in users, posts, or some other model
# Takes in a list of headers
# Takes in a path to where the report should be generated
def generate_report(records, headers, record_path)
  CSV.open(report_path, 'wb') do |csv|
    csv << headers

    records.each do |record|
      csv << yield(record)
    end
  end

  p "Report generated: #{report_path}"
end
