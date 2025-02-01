#calc_gui.rb
require 'gtk3'

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
        create_scientific_tab 
        create_generator_tab
       
        @window.show_all
    end

    private

    def create_basic_tab
        basic_box = Gtk::Box.new(:vertical, 5)
        basic_box.pack_start(@display, expand: false, fill: true, padding: 5)
        
        # Create grid for buttons
        grid = Gtk::Grid.new
        grid.row_spacing = 5
        grid.column_spacing = 5

        buttons = [
            ['7', '8', '9', '/'],
            ['4', '5', '6', '*'],
            ['1', '2', '3', '-'],
            ['0', '.', '=', '+']
        ]

        buttons.each_with_index do |row, i|
            row.each_with_index do |label, j|
                button = Gtk::Button.new(label: label)
                button.signal_connect("clicked") { button_clicked(label) } 
                grid.attach(button, j, i, 1, 1)
            end
        end

        basic_box.pack_start(grid, expand: true, fill: true, padding: 5)
        @notebook.append_page(basic_box, Gtk::Label.new("Basic"))
    end

    def create_scientific_tab
        sci_box = Gtk::Box.new(:vertical, 5)

        grid = Gtk::Grid.new
        grid.row_spacing = 5
        grid.column_spacing = 5

        scientific_buttons = [
            ['√', '∛', 'log(base, a)', 'x^y'],
            ['sin', 'cos', 'tan', '|x|'],
            ['bin', 'oct' , 'hex' , 'n!'],
            ['percentage(a,b)', '', '', '']
        ]

        scientific_buttons.each_with_index do |row, i|
            row.each_with_index do |label, j|
                next if label.empty?
                button = Gtk::Button.new(label: label)
                button.signal_connect("clicked") { scientific_clicked(label) } 
                grid.attach(button, j, i, 1, 1)
            end
        end
    
        sci_box.pack_start(grid, expand: true, fill: true, padding: 5)
        @notebook.append_page(sci_box, Gtk::Label.new("Scientific"))
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

        # Create range-based generators
        range_generators.each do |label|
            row_box = Gtk::Box.new(:horizontal, 5)
            create_range_input(row_box, label)
            gen_box.pack_start(row_box, expand: false, fill: true, padding: 5)
        end

        # Create single-number generators
        single_number_generators.each do |label|
            row_box = Gtk::Box.new(:horizontal, 5)
            create_single_number_input(row_box, label)
            gen_box.pack_start(row_box, expand: false, fill: true, padding: 5)
        end

        # Create list-based generators
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

        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(start_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(Gtk::Label.new("to"), expand: false, fill: true, padding: 5)
        row_box.pack_start(end_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)

        generate_button.signal_connect("clicked") do
            generate_range_numbers(label, start_entry.text.to_i, end_entry.text.to_i)
        end
    end

    def create_single_number_input(row_box, label)
        label_widget = Gtk::Label.new(label)
        number_entry = Gtk::Entry.new
        generate_button = Gtk::Button.new(label: "Generate")

        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(number_entry, expand: false, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)

        generate_button.signal_connect("clicked") do
            generate_sequence_to_n(label, number_entry.text.to_i)
        end
    end

    def create_list_input(row_box, label)
        label_widget = Gtk::Label.new(label)
        numbers_entry = Gtk::Entry.new
        generate_button = Gtk::Button.new(label: "Generate")

        row_box.pack_start(label_widget, expand: false, fill: true, padding: 5)
        row_box.pack_start(numbers_entry, expand: true, fill: true, padding: 5)
        row_box.pack_start(generate_button, expand: false, fill: true, padding: 5)

        numbers_entry.placeholder_text = "Enter numbers separated by commas"

        generate_button.signal_connect("clicked") do
            numbers = numbers_entry.text.split(',').map(&:strip).map(&:to_i)
            generate_from_list(label, numbers)
        end
    end

    def button_clicked(value)
        case value 
        when '=' 
            begin
                result = eval(@display.text)
                @display.text = result.to_s
            rescue
                @display.text = 'Error'
            end 
        else
            @display.text = @display.text + value
        end 
    end

    def scientific_clicked(operation)
        case operation
        when 'log(base, a)'
            # Show dialog for base and value input
            dialog = Gtk::Dialog.new(
                title: "Logarithm Input",
                parent: @window,
                flags: :modal,
                buttons: [["Cancel", :cancel], ["OK", :ok]]
            )
 
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
 
            dialog.run do |response|
                if response == :ok
                    base = base_entry.text.to_f
                    value = value_entry.text.to_f
                    result = Math.log(value, base) rescue 'Error'
                    @display.text = result.to_s
                end
                dialog.destroy
            end
        when 'percentage(a,b)'
            dialog = Gtk::Dialog.new(
                title: "Percentage Calculator",
                parent: @window,
                flags: :modal,
                buttons: [["Cancel", :cancel], ["OK", :ok]]
            )
 
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
 
            dialog.run do |response|
                if response == :ok
                    a = a_entry.text.to_f
                    b = b_entry.text.to_f
                    begin
                        result = (a / b * 100).round(2)
                        @display.text = "#{result}%"
                    rescue
                        @display.text = 'Error'
                    end
                end
                dialog.destroy
            end
        else
            @display.text = "#{operation}(#{@display.text})"
        end
    end

    def generate_range_numbers(type, start_val, end_val)
        result = case type
        when 'Even Numbers'
            (start_val..end_val).select(&:even?)
        when 'Odd Numbers'
            (start_val..end_val).select(&:odd?)
        when 'Square Numbers'
            (start_val..end_val).map { |n| n * n }
        end
        @display.text = result.join(', ')
    end

    def generate_sequence_to_n(type, n)
        result = case type
        when 'Prime Numbers'
            primes_up_to(n)
        when 'Fibonacci Numbers'
            fibonacci_up_to(n)
        end
        @display.text = result.join(', ')
    end

    def generate_from_list(type, numbers)
        result = case type
        when 'Median'
            sorted = numbers.sort
            len = sorted.length
            len.odd? ? sorted[len/2] : (sorted[len/2-1] + sorted[len/2]) / 2.0
        when 'Minimum'
            numbers.min
        when 'Mode'
            numbers.group_by(&:itself).max_by { |_, v| v.size }[0]
        when 'Mean'
            numbers.sum.to_f / numbers.length
        when 'Maximum'
            numbers.max
        end
        @display.text = result.to_s
    end

    def primes_up_to(n)
        primes = []
        (2..n).each do |num|
            primes << num if (2..Math.sqrt(num)).none? { |i| num % i == 0 }
        end
        primes
    end

    def fibonacci_up_to(n)
        sequence = [1, 1]
        while sequence.last < n
            sequence << sequence[-1] + sequence[-2]
        end
        sequence.pop if sequence.last > n
        sequence
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
