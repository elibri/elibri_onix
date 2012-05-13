require 'rubygems'
require 'lib/elibri_onix'

File.open("FIELDS.rdoc", 'w') do |f|
  f.write("= List of attributes in Elibri_Onix classes\n\n")
  Elibri::ONIX::Release_3_0.constants.sort.each do |submodule|
    f.write("== #{submodule}\n")
    f.write "=== Attributes\n" + "Elibri::ONIX::Release_3_0::#{submodule}".constantize::ATTRIBUTES.join(", ")
    f.write "\n"
    f.write "=== Relations\n" + "Elibri::ONIX::Release_3_0::#{submodule}".constantize::RELATIONS.join(", ") unless "Elibri::ONIX::Release_3_0::#{submodule}".constantize::RELATIONS.empty?
    f.write "\n\n"
  end
end