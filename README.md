# taxon-tools

_Tools for working with taxonomic names_

## Tools

### `matchnames`

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

`matchnames` can either use an internal function for calculating fuzzy
matches (`levenstein()`; the default), or the external
[`aregex`](https://github.com/camwebb/gawk-aregex) extension library,
part of the `gawkextlib` project. I think the latter should be
significantly quicker, but I have not yet quantified it. The former
seems to work fine on small to medium datasets, and is more
portable. To make the latter, use:

    make aregexversion

To run this version, the `aregex.so` file must be present in a
directory in `$AWKLIBPATH` (of both user (and root?)).  See:
<https://github.com/camwebb/gawk-aregex>.

### `parsenames`

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

## Installation

All tools are AWK scripts for use with the Gawk flavor of AWK.

### Linux

Make sure environmental variables are set (e.g., in `.bashrc`): 

    export AWKPATH=.:/usr/share/awk/:/usr/local/share/awk/
    export AWKLIBPATH=.:/usr/lib/gawk/:/usr/local/lib/gawk/
    
and that `/usr/local/bin/` is in $PATH. E.g.:

    export PATH=/usr/local/bin/:$PATH

Install with:

    make check
    make install

Commands `matchnames` and `parsenames` should now work anywhere.

### Mac

Should be the same as Linux, but you will need to install GNU Gawk
first (via, e.g., Homebrew).  The MacOS `awk` is not `gawk`.

### Windows

`matchnames` can be easily run using Gawk cross-compiled for Windows,
and the `CMD.EXE` command prompt:

 * Download Gawk from
   [Ezwinports](https://sourceforge.net/projects/ezwinports/files/) and unzip
   on the Desktop.
 * Download the latest `taxon-tools` release from github: 
   <https://github.com/camwebb/taxon-tools/releases/>, and unzip on the 
   Desktop.
 * In the menubar search box, type `CMD.EXE` and open it. This is the old
   DOS commandline.
 * Type these commands (altering the verson numbers if different. The
   latest `CMD.EXE` has command line TAB-completion which speeds
   things up. Basic commands: `dir` = view directory files, `cd` =
   change directory, `copy`, `more` = see file contents.

    cd Desktop\work\taxon-tools-1.1\taxon-tools-1.1
    dir
    copy share\taxon-tools.awk .
    ..\..\gawk-5.1.0-w32-bin\bin\gawk.exe -f matchnames
    ..\..\gawk-5.1.0-w32-bin\bin\gawk.exe -f matchnames -a test\listA -b test\listB -o out.txt -F
    dir
    more out.txt

