#!/nfs/zfs-student-2/users/2013/jmaurice/.brew/bin/python3

# todo : operator=, heritage, exception, const all parameters, exceptions

class_name = "Game"
herit_from = []
attributs = [("std::vector", "board"), ('bool','endgame')]
output_dir = "./"
setters = False;

##################################

header = open(output_dir + class_name + ".hpp", 'w')
src = open(output_dir + class_name + ".cpp", 'w')

# Header file

header.write("\n#ifndef {}_H\n".format(class_name.upper()))
header.write("# define {}_H\n\n".format(class_name.upper()))
header.write("# include <iostream>\n")
header.write("# include <string>\n\n")
header.write("# include <vector>\n\n")

for _ in herit_from:
    header.write('# include "{}.hpp"\n'.format(_));

header.write("\nclass {}".format(class_name));

if len(herit_from) > 0:
    header.write(" :")
    for _ in herit_from:
    	header.write(" public {},".format(_));

header.write("\n{\nprivate:\n")

for type, att in attributs:
    header.write('    {} {};\n'.format(type, '_' + att))

### public
header.write('\npublic:\n')

# default constructor
header.write('    {}(void);\n'.format(class_name))

# full constructor
header.write('    {0}('.format(class_name))
for type, att in attributs:
    header.write('{} {}, '.format(type, att))
header.write(');'.format(class_name))

# copy constructor
header.write('\n    {0}({0} const & src);'.format(class_name))

# destructor
header.write('\n    ~{}(void);\n'.format(class_name))

# operator=
header.write('\n    {0} & operator=({0} const & other);\n'.format(class_name));

# getters, setters
for type, att in attributs:
    header.write('    {} get{}(void) const;\n'.format(type, att.capitalize()))
    if setters:
        header.write('    void set{}({} {});\n'.format(att.capitalize(), type, att))

# operator<<
header.write('};\n\n')
header.write('std::ostream & operator<<(std::ostream & o, {} const & i);\n'.format(class_name))

header.write('\n#endif\n')
header.close()

####################################
# Source file

src.write('\n#include "{}.hpp"\n'.format(class_name))

# default constructor
src.write('\n{0}::{0}()\n{{\n}}\n'.format(class_name))

# full constructor
src.write('\n{0}::{0}('.format(class_name))
for type, att in attributs:
    src.write('{} {}, '.format(type, att))
src.write(') : '.format(class_name))
for type, att in attributs:
    src.write('_{0}({0}), '.format(att))
src.write('\n{\n}\n');

# copy constructor
src.write('\n{0}::{0}({0} const & src)\n{{\n    *this = src;\n}}'.format(class_name))

# destructor
src.write('\n\n{0}::~{0}()\n{{\n}}'.format(class_name))

# operator=
src.write('\n\n{0} & {0}::operator=({0} const & other)\n{{\n'.format(class_name))
for type, att in attributs:
    src.write('    this->_{0} = other._{0};\n'.format(att))
src.write('    return *this;\n}}'.format(class_name));

# getters setters
for type, att in attributs:
    src.write('\n\n{} {}::get{}(void) const\n{{\n    return this->_{};\n}}'.format(type, class_name, att.capitalize(), att))
    if setters:
        src.write('\n\nvoid {}::set{}({} {})\n{{\n    this->_{} = {};\n}}'.format(class_name, att.capitalize(), type, att, att, att))

# operator<<
src.write('\n\nstd::ostream & operator<<(std::ostream & o, {} const & rhs)\n{{\n    o << ...;\n    return o;\n}}\n'.format(class_name))

#####################################
