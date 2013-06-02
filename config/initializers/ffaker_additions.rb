#custom additions to FFaker html ipsum

module Faker
  module HTMLIpsum
    def fancy_string(count = 3, include_breaks = false)
      sep  = include_breaks ? "<br>" : " "
      a = k([
        "<strong>#{words(2).capitalize!}</strong>.",
        "<em>#{paragraph}</em>",
        "<code>#{words 2}</code>",
      ] + Faker::Lorem::paragraphs(count))
      a.random_pick(count).join(sep)
    end

    def body_content
      s = ''

      rand(6).times do
        s << "<p>#{fancy_string}</p>"
      end
      s << table(rand(4))
      s << "<h2>#{words(2).capitalize!}</h2>
      <ol>"
      rand(4).times do
        s << "<li>#{paragraph 1}</li>"
      end
      s << "</ol>
      <blockquote><p>#{paragraphs 3}</p></blockquote>
      <h3>#{words(2).capitalize!}</h3>"

      rand(6).times do
        s << "<p>#{fancy_string}</p>"
      end

      s << "<ul>"
      rand(4).times do
        s << "<li>#{paragraph 1}</li>"
      end
      s << "</ul>"

      rand(3).times do
        s << "<p>#{fancy_string}</p>"
      end

      s
    end

    def sidebar_content
      s = "<h5>#{words(2).capitalize!}</h5>"

      (rand(3) + 1).times do
        s << "<p>#{fancy_string}</p>"
      end

      s
    end

    def table(rows = 3)
      s = "<table>
<thead>
<tr>
<th>#{word.capitalize!}</th>
<th>#{word.capitalize!}</th>
<th>#{word.capitalize!}</th>
<th>#{word.capitalize!}</th>
</tr>
</thead>
<tbody>"
      rows.times do
        s << "<tr>
<td>#{words(1).capitalize!}</td>
<td>#{words(1).capitalize!}</td>
<td>#{words(1).capitalize!}</td>
<td>#{words(2).capitalize!}</td>
</tr>"
      end
      s << "</tbody>
</table>"
    end    
  end
end