# taxon-tools

_Tools for working with taxonomic names_

## matchnames

Reconciling small variations in taxonomic names facilitates the
integration of biological names-based data.  This tool matches a query
list of (parsed) taxonomic names (List A) against a reference list
(List B), according to a set of taxonomic rules (described below). The
taxonomic rules are most appropriate for plant names, as specified by
the International Code of Botanical Nomenclature.  Can also perform
approximate (fuzzy) matching to identify variations (e.g.,
misspelling) in binomial names and author strings. An output status
code is given for each type of match.

See the [man](doc/matchnames.md) page for more details.

## parsenames

Split biological names into component parts:

 1. Genus hybrid sign
 2. Genus name
 3. Species hybrid sign
 4. Specific epithet
 5. Infraspecific rank signifier (“subsp.”, “var.”, etc.)
 6. Infraspecific epithet
 7. Name’s author string

Most of the work is done by a single regular expression. See the
[man](doc/parsenames.md) page for more details.
