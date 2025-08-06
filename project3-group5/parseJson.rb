require 'json'

def parseJson (completed_courses)

  File.open("courses_data.json", "w") do |file|
    file.write(JSON.pretty_generate(completed_courses))
  end

  # Load the JSON file
  file_path = 'courses_data.json'
  data = JSON.parse(File.read(file_path))

  # Process each course entry and update the existing structure
  data.each do |course|
    course_str = course.delete("Course: ") # Remove the "Course: " key

    # Extract semester (first four characters)
    semester_year = course_str[0, 4]
    course["semester"] = semester_year[0, 2]  # First two characters are the semester (e.g., "AU", "SP")
    course["year"] = semester_year[2, 2]  # Last two characters are the year (e.g., "23", "24")

    # Extract department and class number
    dept_and_num = course_str.split(" - ")[0].split.last(2)
    course["Department"] = dept_and_num[0]
    course["Class Number"] = dept_and_num[1]

    # Extract class name
    course["Class Name"] = course_str.split(" - ")[1].split(" (")[0]

    # Extract section number (inside parentheses)
    section_match = course_str.match(/\((\d+)\)/)
    course["Section Number"] = section_match ? section_match[1] : "N/A"
  end

  # Write the updated data back to the same file
  File.open(file_path, 'w') do |file|
    file.write(JSON.pretty_generate(data))
  end
end
