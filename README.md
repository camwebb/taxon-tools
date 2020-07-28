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

`matchnames` can either use i) an internal function for calculating
fuzzy matches (`levenstein()`; **the default**), or ii) the external
[`aregex`](https://github.com/camwebb/gawk-aregex) extension library,
part of the `gawkextlib` project. The latter is ~8 times faster (e.g.,
4.2 s vs. 35.3 s on a no-user-input fuzzy match (`-F`) with the `-a`
file of 2,823 lines and the `-b` file of 19,435 lines, fuzzy error of
5), but less portable and longer to install.  

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

For the **default** (no dependency) version, the `matchnames` and
`parsenames` scripts can be copied wherever needed, or placed
somewhere in the user’s `PATH` environmental variable.  Just make sure
`gawk` is at: `/bin/gawk`, or that `/bin/gawk` is a symlink pointing
to `gawk`, or edit the first line of `matchnames` and `parsenames` to
point to `gawk`.

For system-wide installation, install with:

    make check
    make install

and make sure that `/usr/local/bin/` is in $PATH. E.g.:

    export PATH=/usr/local/bin/:$PATH

For the (faster) **aregex version**, first build and install
`aregex.so`; see
<https://github.com/camwebb/gawk-aregex>. Environmental variable
`$AWKLIBPATH` must include the install directory
(`/usr/local/lib/gawk/` by default), E.g., in `.bashrc`:

    export AWKLIBPATH=.:/usr/lib/gawk/:/usr/local/lib/gawk/
    export PATH=/usr/local/bin/:$PATH

Then:

    make aregexversion
    make check
    make install

To check and run this version. Commands `matchnames` and `parsenames`
should now work anywhere.


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
   DOS commandline. MS `Powershell` can also be used.

Type these commands (altering the verson numbers if different). The
latest `CMD.EXE` has command line TAB-completion which speeds things
up. Basic commands: `dir` = view directory files, `cd` = change
directory, `copy`, `more` = see file contents.

    cd Desktop\taxon-tools-1.1
    dir
    ..\gawk-5.1.0-w32-bin\bin\gawk.exe -f matchnames
    ..\gawk-5.1.0-w32-bin\bin\gawk.exe -f matchnames -a test\listA -b test\listB -o out.txt -F
    dir
    more out.txt

