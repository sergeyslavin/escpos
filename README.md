# Escpos

A ruby implementation of ESC/POS (thermal) printer command specification.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'escpos'

# see https://github.com/escpos/escpos-image
gem 'escpos-image' # add this if you want to print PNG images
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install escpos

## Examples

![](https://github.com/escpos/escpos/blob/master/examples/IMG_20160608_001339_HDR.jpg)
![](https://github.com/escpos/escpos/blob/master/examples/IMG_20160610_161302_HDR.jpg)
![](https://github.com/escpos/escpos/blob/master/examples/IMG_20160610_204358_HDR.jpg)
![](https://github.com/escpos/escpos-image/blob/master/examples/IMG_20160610_232415_HDR.jpg)

## Usage

```ruby
@printer = Escpos::Printer.new
@printer.write "Some text"

@printer.to_escpos # returns ESC/POS data ready to be sent to printer
# on linux this can be piped directly to /dev/usb/lp0
# with network printer sent directly to printer socket
# with serial port printer it can be sent directly to the serial port

@printer.to_base64 # returns base64 encoded ESC/POS data

# using report class

# my_report.rb:
class MyReport < Escpos::Report
  def initialize(arg)
    super(arg)

    # width of printer tape
    # letter_width: average width of letter
    config(
      width: 600,
      letter_width: 15
    )
  end

  def item(text)
    @count ||= 0
    @count += 1
    quad_text "#{@count}. #{text}"
  end
end

```

```erb
<% # my_report.erb: %>
<%= item "First item" %>
<%= item "Second item" %>
<%= item "Third item" %>
```

```ruby
# usage:

report = MyReport.new 'path/to/my_report.erb'
@printer.write report.render
@printer.cut!
# @printer.to_escpos or @printer.to_base64 contains resulting ESC/POS data
```

## Table

```ruby
table = list([
  row([
    col("1234", width: 10),
    col("Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Donec gravida ligula sit amet sapien tincidunt suscipit.", width: 80),
    col("20", width: 10)
  ])
])
# total width should be 100 %
```

## Available helper methods

- **text**: Normal text formatting
- **encode**: Encode text for the printer
- **encoding, set_encoding, set_printer_encoding**: Set printer encoding
- **double_height**: Double height text
- **quad_text, big, title, header, double_width_double_height, double_height_double_width**: Double width & Double height text
- **double_width**: Double width text
- **underline, u**: Underlined text
- **underline2, u2**: Stronger underlined text
- **bold, b**: Bold text
- **left**: Align to left
- **right**: Align to right
- **center**: Align to center
- **invert, inverted**: Color inverted text
- **black, default_color, color_black, black_color**: Default Color (Usually black)
- **red, alt_color, alternative_color, color_red, red_color**: Alternative Color (Usually Red)
- **barcode**: Print barcode
- **partial_cut**: Partially cut the paper (may not be available on all devices)
- **cut**: Fully cut the paper (may not be available on all devices)
- **tab**: Tab
- **dash_line**: ---------- Dash line
- **line**: _____________ Underscore line
- **fit_line**: Auto width of underscore line
- **fit_dash_line**: Auto width of dash line
- **new_line**: New line
- **new_line_and_tab**: New line and tab


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/escpos/escpos.

1. Fork it ( https://github.com/escpos/escpos/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
