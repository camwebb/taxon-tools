% MATCHNAMES(1) taxon-tools version 1.0 | Taxon-tools manual
% 
% Dec 21 2018

# NAME

matchnames - matches two lists of taxonomic names

# SYNOPSIS

matchnames -a query_names_file -b ref_names_file -o outfile \
            [ -f [ -e fuzz_error ]] [ -1 -s -c ]

# DESCRIPTION

Reconciling small variations in taxonomic names is fundamental to
integrating biological data.  This too matches a query list of
(parsed) taxonomic names against a reference list, according to a set
of taxonomic rules (described below). Can also perform approximate
(fuzzy) matching to identify variations in binomial names and author
strings.

## Input file format

Each line represents the elements of a name. Eight pipe-delimited
(“|”) fields per row: 1. User ID code, 2. Genus hybrid sign (“×” =
Unicode “MULTIPLICATION SIGN” `C3 97`), 3. Genus, 4. Species hybrid
sign (“×”), 5. Specific epithet, 6. Infraspecific rank signifier
(“subsp.”, “var.”, etc.), 7. Infraspecific epithet, 8. Name’s author
string.

## Output file format

Each line represents a single name from the query list (list
A). Seventeen pipe-delimited (“|”) fields per row: 1. User ID code in
list A, 2. Used code in list B (if matched), 3. Match type (see codes
above), 4-10. Parsed elements of name in list A. 11-17 (in same format
as name input), Parsed elements of name in list B.

# OPTIONS

-a
: Filename for input list A

-b
: Filename for input list B

-o
: Filename for output

-f
: Use fuzzy matching on names not exactly or automatically matching

-e
: Max Levenshtein distance to allow for fuzzy matching. Default: 

-1
:  

-s 
:

-c
:

# EXAMPLE


# AUTHOR

Cam Webb <cw@camwebb.info>

# COPYING PERMISSIONS

Due to the GPL license off the `gawkextlib` dependency, this program
is released under the GPL 3.0.

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

