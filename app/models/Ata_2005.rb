# coding: utf-8

require 'thinreports'

report = Thinreports::Report.new layout: 'Ata_2005'

# 1st page
report.start_new_page

report.page.item(:textestablecimiento).value('Thinreports')
report.page.item(:textprofesional).value('Thinreports')
report.page.item(:textcodigo).value('Thinreports')
report.page.item(:textnombre).value('Thinreports')
report.page.item(:texttipoestable).value('Thinreports')
report.page.item(:textdeparta).value('Thinreports')
report.page.item(:textfecha).value('Thinreports')
report.page.item(:textmunicipio).value('Thinreports')
report.page.item(:textfecha).value('Thinreports')
report.page.item(:ce).value('Thinreports')
report.page.item(:e).value('Thinreports')
report.page.item(:f).value('Thinreports')
report.page.item(:textespe).value('Thinreports')

# 2nd page
report.start_new_page do |page|
  
  page.item(:textestablecimiento).value('Example').style(:color, '#ff0000')
  page.item(:textprofesional).value('Maritza Mejia').style(:color, '#000000')
  page.item(:secretaria).style(:color, '#ff0000')
  page.item(:textcodigo).value('Thinreports')
  page.item(:textnombre).value('Thinreports')
  page.item(:texttipoestable).value('Thinreports')
  page.item(:textdeparta).value('Thinreports')
  page.item(:textfecha).value('Thinreports')
  page.item(:textmunicipio).value('Thinreports')
  page.item(:textfecha).value('Thinreports')
  page.item(:ce).value('Thinreports')
  page.item(:e).value('Thinreports')
  page.item(:f).value('Thinreports')
  page.item(:textespe).value('Thinreports')
end

# 3rd page
#report.start_new_page do
  #item(:world).value('Hello')
  #item(:hello).hide
#end

# 4th page
#report.start_new_page do
  #values(world: 'World',
         #thinreports: 'Thinreports')
#end

report.generate(filename: 'Ata_2005.pdf')

puts 'Done!'