require 'rubygems'
require 'json'

# Method to read and parse the JSON file
def read_json(file_path)
  JSON.parse(File.read(file_path))
end

# Main method that integrates everything
def generate_html_from_json(file_path)

    data = read_json(file_path)
    write_header

    write_body(data)

end

def write_header

    header = <<~TEXT
    <!DOCTYPE html>
     <html lang="en">
     <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Course List</title>
     </head>\n
    TEXT

    File.open("courses.html", "w") do |file|
        file.write(header)
    end
end

def write_body(data)
    body = "<body>\n"
    body << "   <h1>Course List</h1>"
    body << "   #{write_table_header}"
    File.open("courses.html", "a") do |file|
        file.write(body)
    end

    File.write("courses.html", "<tbody>\n", mode: "a")
    data.each do |course|
        table = "   #{write_table_body(course)}"
        File.open("courses.html", "a") do |file|
            file.write(table)
        end
    end
    File.write("courses.html", "</tbody>\n</table>\n</body>\n</html>", mode: "a")
end

def write_table_header
    table = <<~TEXT
      <table>
        <thead>
          <tr>
            <th>Semester</th>
            <th>Year</th>
            <th>Department</th>
            <th>Class Number</th>
            <th>Class Name</th>
            <th>Section Number</th>
          </tr>
        </thead>
    TEXT
end

def write_table_body(course)
    table = <<~TEXT
    <tr>
      <td>#{course['semester']}</td>
      <td>#{course['year']}</td>
      <td>#{course['Department']}</td>
      <td>#{course['Class Number']}</td>
      <td>#{course['Class Name']}</td>
      <td>#{course['Section Number']}</td>
    </tr>
    TEXT
end

