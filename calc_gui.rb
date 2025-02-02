#author: Ryan Carmody
#Calculator GUI for project 2 part 2

#calc_gui.rb
require 'gtk3'
require_relative 'cosine'
require_relative 'cubic_root'
require_relative 'deci_to_bi'
require_relative 'deci_to_hex'
require_relative 'deci_to_oct'
require_relative 'even_numbers'
require_relative 'exponent'
require_relative 'factorial'
require_relative 'fibonacci'
require_relative 'generate_odd'
require_relative 'generate_primes'
require_relative 'logarithm'
require_relative 'max'
require_relative 'mean'
require_relative 'median'
require_relative 'minimum'
require_relative 'mode'
require_relative 'percentage'
require_relative 'is_prime'
require_relative 'sine'
require_relative 'square_numbers'
require_relative 'square_root'
require_relative 'tangent'
require_relative 'fahrenheit_to_celsius'
 
class CalculatorGUI
    def initialize
        @builder = Gtk::Builder.new

        # Create main window
        @window = Gtk::Window.new("Scientific Calculator")
        @window.set_default_size(600, 400)
        @window.signal_connect("destroy") { Gtk.main_quit }
        
        # Create notebook (tabbed interface)
        @notebook = Gtk::Notebook.new
        @window.add(@notebook)
        
        # Create main display
        @display = Gtk::Entry.new
        @display.editable = false
        
        # Create tabs
        create_basic_tab
        create_generator_tab
       
        @window.show_all
    end

    private

    def create_basic_tab
        basic_box = Gtk::Box.new(:vertical, 5)
        basic_box.pack_start(@display, expand: false, fill: true, padding: 5)
        
        # Create grid for basic buttons
        basic_grid = Gtk::Grid.new
        basic_grid.row_spacing = 5
        basic_grid.column_spacing = 5

        # Add a label for the basic section
        basic_label = Gtk::Label.new
        basic_label.set_markup("<b>Basic Operations</b>")  # Bold text
        basic_box.pack_start(basic_label, expand: false, fill: true, padding: 5)

        # Initialize basic operation buttons
        buttons = [
            ['7', '8', '9', '/'],
            ['4', '5', '6', '*'],
            ['1', '2', '3', '-'],
            ['0', '.', '=', '+'],
            ['Clear', '(', ')', 'Delete']
        ]

        # Connecting click signal to buttons
        buttons.each_with_index do |row, i|
            row.each_with_index do |label, j|
                button = Gtk::Button.new(label: label)
                button.signal_connect("clicked") { button_clicked(label) } 
                basic_grid.attach(button, j, i, 1, 1)
            end
        end

        basic_box.pack_start(basic_grid, expand: true, fill: true, padding: 5)

        # Add scientific section
        scientific_label = Gtk::Label.new
        scientific_label.set_markup("<b>Scientific Operations</b>")  # Bold text
        basic_box.pack_start(scientific_label, expand: false, fill: true, padding: 5)

        scientific_grid = Gtk::Grid.new
        scientific_grid.row_spacing = 5
        scientific_grid.column_spacing = 5

        # Initialize scientific operation buttons
        scientific_buttons = [
            ['√', '∛', 'log(base, a)', 'x^y'],
            ['sin', 'cos', 'tan', '|x|'],
            ['bin', 'oct', 'hex', 'n!'],
            ['percentage(a,b)', '', '', '']
        ]

        # Connecting click signal to buttons
        scientific_buttons.each_with_index do |row, i|
            row.each_with_index do |label, j|
                next if label.empty?
                button = Gtk::Button.new(label: label)
                button.signal_connect("clicked") { scientific_clicked(label) } 
                scientific_grid.attach(button, j, i, 1, 1)
            end
        end

        # Multi-tab interface implementation
        basic_box.pack_start(scientific_grid, expand: true, fill: true, padding: 5)
        @notebook.append_page(basic_box, Gtk::Label.new("Calculator"))
    end

        
    def create_generator_tab
        gen_box = Gtk::Box.new(:vertical, 5)
        
        # Generators that need range (start to end)
        range_generators = [
            'Even Numbers',
            'Odd Numbers',
            'Square Numbers'
        ]
    
        # Generators that need a single number (1 to n)
        single_number_generators = [
            'Prime Numbers',
            'Fibonacci Numbers'
        ]
    
        # Generators that need comma-separated numbers
        list_generators = [
            'Median',
            'Minimum',
            'Mode',
            'Mean',
            'Maximum'
        ]
    
        # Add Temperature Converter section
        temp_label = Gtk::Label.new
        temp_label.set_markup("<b>Temperature Converter</b>")
        gen_box.pack_start(temp_label, expand: false, fill: true, padding: 5)
    
        # Formating the temp conversion section
        temp_box = Gtk::Box.new(:horizontal, 5)
        temp_label = Gtk::Label.new("Fahrenheit to Celsius:")
        temp_entry = Gtk::Entry.new
        convert_button = Gtk::Button.new(label: "Convert")
        result_display = Gtk::Entry.new
        result_display.editable = false
        result_display.placeholder_text = "Result will appear here"
    
        temp_box.pack_start(temp_label, expand: false, fill: true, padding: 5)
        temp_box.pack_start(temp_entry, expand: false, fill: true, padding: 5)
        temp_box.pack_start(convert_button, expand: false, fill: true, padding: 5)
        temp_box.pack_start(result_display, expand: true, fill: true, padding: 5)
    
        # Connecting click signal to generate result
        convert_button.signal_connect("clicked") do
            begin
                fahrenheit = temp_entry.text.to_f
                celsius = fahrenheit_to_celsius(fahrenheit)
                result_display.text = "#{celsius.round(2)}°C"
            rescue => e
                result_display.text = "Error: Invalid input"
            end
        end
    
        gen_box.pack_start(temp_box, expand: false, fill: true, padding: 5)
    
        # Formatting the different input's for various generators
        range_generators.each do |label|
            row_box = Gtk::Box.new(:horizontal, 5)
            create_range_input(row_box, label)
            gen_box.pack_start(row_box, expand: false, fill: true, padding: 5)
        end
    
        single_number_generators.each do |label|
            row_box = Gtk::Box.new(:horizontal, 5)
            create_single_number_input(row_box, label)
            gen_box.pack_start(row_box, expand: false, fill: true, padding: 5)
        end
    
        list_generators.each do |label|
            row_box = Gtk::Box.new(:horizontal, 5)
            create_list_input(row_box, label)
            gen_box.pack_start(row_box, expand: false, fill: true, padding: 5)
        end
    
        @notebook.append_page(gen_box, Gtk::Label.new("Generators"))
    end

    def create_range_input(row_box, label)
        label_widget = Gtk::Label.new(label)
        start_entry = Gtk::Entry.new
        end_entry = Gtk::Entry.new
        generate_button = Gtk::Button.new(label: "Generate")

        # Adding widgets with spacing and layout specifiers
        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(start_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(Gtk::Label.new("to"), expand: false, fill: true, padding: 5)
        row_box.pack_start(end_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)

        # Connecting click signal to generate range of numbers 
        generate_button.signal_connect("clicked") do
            generate_range_numbers(label, start_entry.text.to_i, end_entry.text.to_i)
        end
    end

    # Creates an input field for a single number
    def create_single_number_input(row_box, label)
        label_widget = Gtk::Label.new(label)
        number_entry = Gtk::Entry.new
        generate_button = Gtk::Button.new(label: "Generate")
    
        # Adding widgets with spacing and layout specifiers
        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(number_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)
            
        # Connecting click signal to generate sequence up to a given number
        generate_button.signal_connect("clicked") do
            generate_sequence_to_n(label, number_entry.text.to_i)
        end
    end
    
    # Generates a sequence based on the selected type
    def generate_sequence_to_n(type, n)
        begin
            case type
            when 'Prime Numbers'
                generate_primes(n)  # Calls the generate primes file
                if File.exist?('primes.txt')
                    numbers = File.read('primes.txt')
                    @display.text = numbers.split("\n").join(", ")
                else
                    @display.text = numbers.join(", ")  # Use returned array as backup
                end
    
            when 'Fibonacci Numbers'
                sequence = fibonacci(n)   # Calls the fibonacci file
                if File.exist?('fibonacci.txt')
                    content = File.read('fibonacci.txt')
                    @display.text = content
                end
            end
        end
    end

    # Creates an input field for a list of numbers
    def create_list_input(row_box, label)
        label_widget = Gtk::Label.new(label)
        numbers_entry = Gtk::Entry.new
        generate_button = Gtk::Button.new(label: "Generate")
        result_display = Gtk::Entry.new  # New display area for result
        result_display.editable = false   # Make it read-only
        result_display.placeholder_text = "Result will appear here"
    
        # Adding widgets with spacing and layout specifiers
        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(numbers_entry, expand: true, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)
        row_box.pack_start(result_display, expand: true, fill: true, padding: 5)  # Add result display
    
        # Instruction for calculator user
        numbers_entry.placeholder_text = "Enter numbers separated by commas"
    
        # Connecting click signal to generate file
        generate_button.signal_connect("clicked") do
            numbers = numbers_entry.text.split(',').map(&:strip).map(&:to_i)
            result = generate_from_list(label, numbers)
            result_display.text = result.to_s  # Show result in the new display area
        end
    end


    def button_clicked(value)
        case value 
        when '='    # Connects the '=' button with signal to show result
            begin
                result = eval(@display.text)
                @display.text = result.to_s
            rescue
                @display.text = 'Error'
            end 
        when 'Clear'
            @display.text = ''  # Clear the display
        when 'Delete'   # Deletes the last entry 
            @display.text = @display.text.chop
        else    
            @display.text = @display.text + value
        end
    end

    def scientific_clicked(operation)
        case operation

        # Opens a pop-up window to enter base and value
        when 'log(base, a)'
            dialog = Gtk::Dialog.new(
                title: "Logarithm Input",
                parent: @window,
                flags: :modal,
                buttons: [["Cancel", :cancel], ["OK", :ok]]
            )
        
            # Formatting the pop-up 
            box = dialog.content_area
            base_label = Gtk::Label.new("Base:")
            base_entry = Gtk::Entry.new
            value_label = Gtk::Label.new("Value:")
            value_entry = Gtk::Entry.new
        
            box.add(base_label)
            box.add(base_entry)
            box.add(value_label)
            box.add(value_entry)
            dialog.show_all
        
            response = dialog.run
            # Check for proper inputs in pop-up
            if response == :ok
                begin
                    base = base_entry.text.to_f
                    value = value_entry.text.to_f
                    if base > 0 && value > 0  # Check preconditions
                        result = logarithm(base, value)     # Calls log file to compute
                        @display.text = result.to_s
                    else
                        @display.text = "Error: Base and value must be > 0"
                    end
                rescue => e
                    @display.text = "Error: Invalid input"
                end
            end
            dialog.destroy 

        # Opens pop up window to enter two values
        when 'percentage(a,b)'
            dialog = Gtk::Dialog.new(
                title: "Percentage Calculator",
                parent: @window,
                flags: :modal,
                buttons: [["Cancel", :cancel], ["OK", :ok]]
            )
        
            # Formatting the pop-up 
            box = dialog.content_area
            a_label = Gtk::Label.new("Enter value (a):")
            a_entry = Gtk::Entry.new
            b_label = Gtk::Label.new("Enter total value (b):")
            b_entry = Gtk::Entry.new
        
            box.add(a_label)
            box.add(a_entry)
            box.add(b_label)
            box.add(b_entry)
            dialog.show_all
        
            response = dialog.run
            # Check for proper inputs in pop-up
            if response == :ok
                begin
                    a = a_entry.text.to_f
                    b = b_entry.text.to_f
                    if b != 0  # Check for division by zero
                        result = percentage(a, b)  # Use the imported percentage function
                        @display.text = "#{result}%"
                    else
                        @display.text = "Error: Cannot divide by zero"
                    end
                rescue => e
                    @display.text = "Error: Invalid input"
                end
            end
            dialog.destroy

        # Computes square root by calling file
        when '√'
            value = @display.text.to_f
            result = square_root(value)
            @display.text = result.to_s
    
        # Computes cube root by calling file
        when '∛'
            value = @display.text.to_f
            result = cubic_root(value)
            @display.text = result.to_s
    
        # Opens pop up window to enter value and exponent value
        when 'x^y'
            dialog = Gtk::Dialog.new(
                title: "Exponent Input",
                parent: @window,
                flags: :modal,
                buttons: [["Cancel", :cancel], ["OK", :ok]]
            )
        
            # Formatting the pop-up 
            box = dialog.content_area
            base_label = Gtk::Label.new("Enter base:")
            base_entry = Gtk::Entry.new
            exp_label = Gtk::Label.new("Enter exponent:")  
            exp_entry = Gtk::Entry.new
        
            box.add(base_label)
            box.add(base_entry)
            box.add(exp_label)
            box.add(exp_entry) 
            dialog.show_all
        
            response = dialog.run
            # Check for proper inputs in pop-up
            if response == :ok
                begin
                    base = base_entry.text.to_f
                    exponent = exp_entry.text.to_i  # Changed back to to_i
                    puts "Base: #{base}, Exponent: #{exponent}"  # Debug output
                    begin
                        result = exponent(base, exponent)
                        puts "Result: #{result}"  # Debug output
                        @display.text = result.to_s
                    rescue => e
                        puts "Error in exponent function: #{e.message}"  # Debug output
                        @display.text = "Error: Calculation error"
                    end
                rescue => e
                    puts "Error converting inputs: #{e.message}"  # Debug output
                    @display.text = "Error: Invalid input"
                end
            end
            dialog.destroy
    
        # Computes sin val by calling file when clicked
        when 'sin'
            value = @display.text.to_f
            result = sine(value)
            @display.text = result.to_s

        # Computes cos val by calling file when clicked
        when 'cos'
            value = @display.text.to_f
            result = cosine(value)
            @display.text = result.to_s
    
        # Computes tan val by calling file when clicked
        when 'tan'
            value = @display.text.to_f
            result = tangent(value)
            @display.text = result.to_s
    
        # Computes absolute val by calling file when clicked
        when '|x|'
            value = @display.text.to_f
            @display.text = value.abs.to_s
    
        # Converts decimal val to binary when clicked
        when 'bin'
            value = @display.text.to_i
            result = deci_to_bi(value)
            @display.text = result.to_s
    
        # Converts decimal val to oct when clicked
        when 'oct'
            value = @display.text.to_i
            result = deci_to_oct(value)
            @display.text = result.to_s
    
        # Converts decimal val to hex when clicked
        when 'hex'
            value = @display.text.to_i
            result = deci_to_hex(value)
            @display.text = result.to_s
    
        # Computes factorial of entered value when clicked
        when 'n!'
            value = @display.text.to_i
            result = factorial(value)
            @display.text = result.to_s
        end
    end

    # 
    def generate_range_numbers(type, start_val, end_val)
        begin
            case type
            # Generates list of even numbers in user provided range
            when 'Even Numbers'
                sequence = even_numbers(start_val, end_val)  # This writes to even_nums.txt
                # Make sure the file exists before trying to read it
                unless sequence.nil?
                    if File.exist?('even_nums.txt')
                        numbers = File.read('even_nums.txt')
                        @display.text = numbers
                    else
                        @display.text = sequence.join(', ')
                    end
                end
            # Generates list of odd numbers in user provided range
            when 'Odd Numbers'
                sequence = generate_odd(start_val, end_val)  # This writes to odd_nums.txt
                unless sequence.nil?
                    if File.exist?('odd_nums.txt')
                        numbers = File.read('odd_nums.txt')
                        @display.text = numbers
                    else
                        @display.text = sequence.join(', ')
                    end
                end
            # Generates list of square numbers in user provided range
            when 'Square Numbers'
                sequence = square_numbers(start_val, end_val)  # This writes to squares.txt
                unless sequence.nil?
                    if File.exist?('squares.txt')
                        numbers = File.read('squares.txt')
                        @display.text = numbers
                    else
                        @display.text = sequence.join(', ')
                    end
                end
            end
        end
    end

    # Case that calls mean, median, etc... when prompted by click
    def generate_from_list(type, numbers)
        result = case type
        when 'Median'
            median(numbers)
        when 'Minimum'
            minimum(numbers)
        when 'Mode'
            mode(numbers)
        when 'Mean'
            mean(numbers)
        when 'Maximum'
            max(numbers)
        end
    end

public
    def run
        Gtk.main
    end 
end
    
# Create and run the calculator
if __FILE__ == $0
    calculator = CalculatorGUI.new
    calculator.run
end
