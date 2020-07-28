% PARSENAMES(1) taxon-tools version 1.0 | Taxon-tools manual
% 
% Dec 27 2018

# NAME

parsenames - parse taxonomic names into component parts

# SYNOPSIS

parsenames names_file > parsed_output

# DESCRIPTION

Split biological names into component parts: 1. Genus hybrid sign, 2. Genus name
3. Species hybrid sign, 4. Specific epithet, 5. Infraspecific rank signifier (“subsp.”, “var.”, etc.), 6. Infraspecific epithet, 7. Name’s author string.

Most of the work is done by a single regular expression.

# FILE FORMATS

## Input file format

Each line represents a name. Two pipe-delimited (“|”) fields per row:
1. User ID code, 2. Taxonomic name.

## Output format

Each line represents a single parsed name from the input list.
1. User ID code, 2. Genus hybrid sign (“×” = Unicode “MULTIPLICATION
SIGN” `C3 97`), 3. Genus, 4. Species hybrid sign (“×”), 5. Specific
epithet, 6. Infraspecific rank signifier (“subsp.”, “var.”, etc.),
7. Infraspecific epithet, 8. Name’s author string.

# SEE ALSO

**matchnames**(1), **parse_taxon_name**(3), https://en.wikipedia.org/wiki/Author_citation_(botany)

# AUTHOR

Cam Webb <cw@camwebb.info>

# COPYING PERMISSIONS

This program is released under the GPL 3.0:

Copyright © 2018, Campbell O. Webb

Permission is granted to make and distribute verbatim  copies  of  this
manual  page  provided  the copyright notice and this permission notice
are preserved on all copies.

Permission is granted to copy and distribute modified versions of  this
manual  page  under  the conditions for verbatim copying, provided that
the entire resulting derived work is distributed under the terms  of  a
permission notice identical to this one.

Permission  is granted to copy and distribute translations of this manual page into another language, under the above conditions for modified
versions,  except that this permission notice may be stated in a trans‐
lation approved by the Foundation.

