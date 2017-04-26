module Escpos
  module Table

    def list(rows = [])
      @data = []
      rows_list = []

      rows.each do |row|
        total_width = row.inject(0) { |sum, e| sum + e[1] }
        raise 'Total width of row should be 100%' if total_width > 100

        row_cols = []
        row.each do |col|
          text, width = col

          lin = width > 50 ? (@letter_in_line - (row.size * 2)) : @letter_in_line
          split_position = ((lin.to_f / 100.0) * width)
          text_list = text.scan(/.{#{split_position.to_i}}|.+/)

          if text_list.size > 2
            range = (1..text_list.size)
            text_list[range] = text_list[range].map(&:strip)
          end

          row_cols << text_list.join(new_line)
        end
        rows_list << row_cols
      end

      ::Terminal::Table.new rows: rows_list
    end

    def row(cols = [])
      cols
    end

    def col(text, width:)
      [text, width]
    end

  end
end
