# require 'escpos'
#
# class Report < Escpos::Report
#
#   def initialize(arg)
#     super(arg)
#
#     config(
#       width: 600,
#       letter_width: 15
#     )
#   end
#
#   def table
#     table = list([
#       row([
#         col("1234", width: 10),
#         col("Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#             Donec gravida ligula sit amet sapien tincidunt suscipit.", width: 80),
#         col("20", width: 10)
#       ]),
#       row([
#         col("1234", width: 10),
#         col("Lorem ipsum dolor sit amet, consectetur adipiscing elit.", width: 80),
#         col("20", width: 10)
#       ])
#     ])
#
#     table.align_column(2, :right)
#     table.style.merge({
#       border_x: '',
#       border_i: '',
#       border_y: '',
#     })
#     table
#   end
#
#   def item(txt)
#     text(txt)
#   end
# end
