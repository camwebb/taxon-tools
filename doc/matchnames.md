% MATCHNAMES(1) taxon-tools version 1.0 | Taxon-tools manual
% 
% Dec 27 2018

# NAME

matchnames - matches two lists of taxonomic names

# SYNOPSIS

matchnames -a query_names_file -b ref_names_file -o outfile \
            [ -f [ -e fuzzy_error ]] [ -1 -c -n ]

# DESCRIPTION

Reconciling small variations in taxonomic names facilitates the
integration of biological names-based data.  This tool matches a query
list of (parsed) taxonomic names (List A) against a reference list
(List B), according to a set of taxonomic rules (described below). The
taxonomic rules are most appropriate for plant names, as specified by
the International Code of Botanical Nomenclature.  Can also perform
approximate (fuzzy) matching to identify variations (e.g.,
misspelling) in binomial names and author strings. An output status
code is given for each type of match.


# OPTIONS

-a
: File name for input list A.

-b
: File name for input list B.

-o
: File name for output. Deleted before each run, unless the append
(_-n_) option is given.

-f
: Use fuzzy matching with manual decision on names not automatically
matching.

-e
: Max Levenshtein distance to allow during fuzzy matching. Default: 10
total insertions, deletions and substitutions.

-1
: If no author is given in list A and the name (without author) occurs
only once in list B, accept the name in list B as a match. 

-c 
: Allow a “canonical name” match if only the genus, species epithet,
and infraspecific epithet (if present) match exactly. Default: to not
allow such a match.

-n
: Append results to output file rather than deleting it before a run.

# FILE FORMATS

## Input file format

Each line represents the elements of a name. Eight pipe-delimited
(“|”) fields per row: 1. User ID code, 2. Genus hybrid sign (“×” =
Unicode “MULTIPLICATION SIGN” `C3 97`), 3. Genus, 4. Species hybrid
sign (“×”), 5. Specific epithet, 6. Infraspecific rank signifier
(“subsp.”, “var.”, etc.), 7. Infraspecific epithet, 8. Name’s author
string. This parsing of names can be generated with the **parsenames**
tool.

## Output file format

Each line represents a single name from the query list (list
A). Seventeen pipe-delimited (“|”) fields per row: 1. User ID code in
list A, 2. Code in list B (if matched), 3. Match type (see codes
below), 4-10. Parsed elements of name in list A. 11-17 (in same format
as name input), Parsed elements of name in list B.

# MATCHING RULES AND OUTPUT CODES

For each name in List A a series of rules are applied in seeking a
match in List B.  The sequence of rules is:

1. Is there an exact match to all parts of the name (genus hybrid
marker, genus name, species hybrid marker, species epithet,
infraspecific rank signifier, infraspecific rank, author sting)? If so
match code is: **exact**.

2. Both query name and reference names are “de-punctuated” to remove
the effect of mis-matching spaces, periods, non-ASCII author name
characters, etc. The depunctuation procedure is: a) converting
non-ASCII characters into their appropriate ASCII character (e.g., “ï”
to “i”), b) converting “and” into “&”, c) removing all punctuation
other than “(“, “)” and “&”, d) converting to lower-case. If an exact
match exists between the depunctuated query string and a depunctuated
reference name, the match code is: **auto_punct**.

3. If the **-1** option has been specified, and if no author is given
in the list A name, and the name (without author) occurs only once in
list B, accept the name in list B automatically. Match code:
**noauth**.

4. If one or the other name is missing a basionym (the name in
parentheses that precedes the author of the given name), a match is
allowed. Match code: **auto_basio+** or **auto_basio-** (the +/-
indicating if the list A name is the one with (+), or without (-) the
basionym.

5. If basionyms are different, a match is allowed. Match code:
**auto_basio**.

6. If one or the other name is missing either an _ex_ or an _in_
element, a match is allowed. (The _ex_ refers to the author of an
invalid publication of the same name; the _in_ indicates that the
author of the document in which the name is published is not the same
as the author of the name.) Match code: **auto_exin+** or
**auto_exin-**.

7. If the names and author strings are the same after all _ex_ and _in_
elements have been stripped, a match is allowed. Match code:
**auto_exin**.

8. If the names and author strings are the same after all _ex_ and
_in_ and basionym elements have been stripped, a match is
allowed. Match code: **auto_basexin**.

9. If there are any list B names that may match approximately the list A
name, move to “manual matching” (see below). Match code: **manual** or
**manual?**.

10. If a name fails manual matching, but option _-c_ has been given,
allow a match by “canonical form” only, i.e., genus plus specific
epithet plus infraspecific epithet (if present), not including the
infraspecific specifier (“subsp.”, etc.). Match code: **cfonly**.

11. At this point, record a failure to match. Match code: **no_match**.

# MANUAL MATCHING

If the manual/fuzzy matching option is given (“-f”), and if no
automatic match is found, but if any approximate matches are found,
these are presented to the user for a “manual” choice to be made.

## Commands during manual matching

1...n
: Accept this numbered entry as the match, with match code “manual”.

1e...ne
: (I.e., the number plus the “e” character) Accept this numbered entry
as the match, but add a low-confidence flag to match code: “manual?”.

e
: No listed option is acceptable. Reject match.

c
: See input codes of the names being offered.

q
: Halt matching process. The output file will contain only members of
List A matched up to this point.

# SEE ALSO

**parsenames**(1), **parse_taxon_name**(3), https://en.wikipedia.org/wiki/Author_citation_(botany)

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

