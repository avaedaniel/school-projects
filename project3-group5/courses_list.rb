require 'net/http'
require 'uri'
require 'json'
require 'date'
require 'dotenv/load'
require_relative 'parseJson.rb'
require_relative 'createHTML.rb'

TOKEN = ENV['CANVAS_API_TOKEN']
BASE_URL = 'https://osu.instructure.com/api/v1'

def get_my_user_id
  uri = URI("#{BASE_URL}/users/self")
  response = api_request(uri)
  
  #puts "DEBUG: User ID response: #{response}" # Debugging output
  
  response ? response['id'].to_s : nil
end

def api_request(uri)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(uri.request_uri)
  request['Authorization'] = "Bearer #{TOKEN}"
  
  response = http.request(request)
  
  #puts "DEBUG: API Request to #{uri} returned #{response.code}" # Debugging output
  
  if response.code.to_i != 200
    puts "Error: API request failed (#{response.code})"
    return nil
  end
  
  JSON.parse(response.body)
rescue JSON::ParserError
  puts "Error: Failed to parse JSON response"
  nil
end

def get_courses
  uri = URI("#{BASE_URL}/courses?per_page=100")
  response = api_request(uri)
  
  #puts "DEBUG: Retrieved courses: #{response}" # Debugging output
  
  response || []
end

def get_enrollments(course_id)
  uri = URI("#{BASE_URL}/courses/#{course_id}/enrollments")
  response = api_request(uri)
  
  #puts "DEBUG: Enrollments for Course #{course_id}: #{response}" # Debugging output
  
  response || []
end

def main
  my_user_id = get_my_user_id
  unless my_user_id
    puts "Error: Could not retrieve user ID"
    return
  end

  courses = get_courses
  completed_courses = []
  puts "Courses you've taken at OSU:\n\n"

  courses.each do |course|
    puts "Course: #{course['name']} (#{course['id']}) with state #{course['workflow_state']}" # Debugging
    course_data = {
      "Course: " => course['name'] || "No Course Name",
      "Course id" => course['id'] || "No Course ID",
    }
    completed_courses << course_data
  end

  parseJson(completed_courses)
  # Path to JSON file
  json_file_path = 'courses_data.json'
  generate_html_from_json(json_file_path)

end

main