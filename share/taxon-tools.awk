function parse_taxon_name(name, test,    parsed, p, remade) {
  # A single regex for matching against species name strings
  # Argument 1: the name
  # Argument 2: 1/0 to trigger a series of tests: the output will be skipped
  #  if the tests fail  

  # Output: pipe-delimited genus_hybrid|genus|species_hybrid|species|
  #        rank|infrasp|author_string

  # Logic:
  #   Genus Author                             : capital forces author (cfa)
  #   Genus species                            : matching from front (mff)
  #   Genus × species                          : mff & hybrid
  #   Genus species Author                     : mff & cfa
  #   Genus species Author & Author            : mff & cfa
  #   Genus species sub                        : rank signifier from list
  #   Genus species sub Author                 :   & cfa
  #   Genus species sub Author & Author        :   & cfa
  #   Genus species rank. sub                  : rank from list & mff
  #   Genus species rank. sub Author           :   & cfa
  #   Genus species rank. sub Author & Author  :   & cfa

  # Note: gawk's [:alpha:] shortens this Author string:
  #   [A-za-z\- ().&;,ÁÅäáâăÉéèěíîíıÖØöóöòøôÜüČçćčğłñńřŞšșțýž']

  
  # Clean bad chars:
  gsub(/[¿\/]/,"",name) 
  # see: https://github.com/GlobalNamesArchitecture/gnresolver/issues/112

  # Use unwrapped/long lines to view regex structure (M-x toggle-truncate-lines)
  #                 ( ×    )   ( genus 2+   )   ( ×    )   ( species 2+      )    ( rank                                                                           )    ( infrasp  )    ( author string           )
  parsed = gensub(/^([×xX]?)\ ?([A-Z][a-zë]+)\ ?([×xX]?\ |[×X]?)\ ?([a-z\-ﬂ][a-z\-ﬂ]+)?\ ?(var\.|f\.|forma|taxon|fo\.|subsp\.|prol\.|nothovar\.|lus\.|\[infrasp\.unranked\])?\ ?([a-z\-ﬂ_]+)?\ ?([- \[\]().&;,'[:alnum:]]+)?$/, "\\1|\\2|\\3|\\4|\\5|\\6|\\7", "G", name);

  
  # issue with 'Genus xspecies': 'Genus xanthophylla' becomes a hybrid
  gsub(/\ *\|/,"|",parsed)
  # Full list of IPNI infra ranks: agamosp.  convar.  f.  forma
  #   [infrasp.unranked] lus.  monstr.  mut.  nm.  nothosubsp.
  #   nothovar.  prol.  proles race subf.  subsp.  subspec.  subvar.  var,
  #   var.

  # Can't find a way to hold lowercase-beginning strings in the author
  # field (rare). E.g., d'Urv, and auct., so fix one by one:
  parsed = gensub(/\|(auctt?)\|\./,"||\\1.","G",parsed)
  parsed = gensub(/\|d\|/,"||d","G",parsed)

  # convert hybrid sign
  gsub(/\|[xX]\|/,"|×|", parsed);
  gsub(/^[xX]\|/,"×|", parsed);
  
  if (test) {
    # # Warn about possible 'xanthophylla' cases (no seems to be fixed)
    # if (name ~ /[^.]\ x[a-z]/)
    #   print "** Warn: '" name "' may be misparsed:\n"     \
    #     "         " parsed "  <- parsed\n" > "/dev/stderr"
    
    # tests
    remade = parsed;
    gsub("\\|"," ",remade);
    gsub(/\ \ +/," ",remade);
    gsub(/^\ /,"",remade);
    gsub(/\ $/,"",remade)
    split(parsed, p, "|");
    if ((parsed !~ /\|/) ||             \
        (p[1] !~ /^[×xX]?$/) ||         \
        (p[2] !~ /^[A-Z][a-zë]+$/) ||                   \
        (p[3] !~ /^[×xX]?$/) ||                             \
        (p[4] !~ /^[a-z\-ﬂ][a-z\-ﬂ]+$/) ||               \
        (p[5] !~ /^([a-z]+\.?|\[infrasp\.unranked\])?$/) ||  \
        (p[6] !~ /^([a-z\-ﬂ][a-z\-ﬂ_]+)?$/) ||               \
        (gensub(/×/,"x","G",depunct(remade)) !=              \
         gensub(/×/,"x","G",depunct(name)))) {
      # print "'" depunct(remade) "'" > "/dev/stderr";
      # print "'" depunct(name)  "'" > "/dev/stderr";
      print "*  Fail: '" name "' does not match:\n"         \
        "         " parsed "  <- parsed\n"> "/dev/stderr";
      # exit 1;
    }
    else return parsed
  }
  else return parsed;
}


function depunct(x) {
  # the master copy of this library is now here in taxon-tools.awk
  
  # See here for data:
  # https://code.activestate.com/recipes/251871-latin1-to-ascii-the-
  #   unicode-hammer/
  # https://stackoverflow.com/questions/1382998/latin-1-to-ascii#1383721
  gsub(/[ùúûü]/,"u", x)
  gsub(/[Ñ]/,"N", x)
  gsub(/[ÀÁÂÃÄÅ]/,"A", x)
  gsub(/[ìíîï]/,"i", x)
  gsub(/[ÒÓÔÕÖØ]/,"O", x)
  gsub(/[Ç]/,"C", x)
  gsub(/[æ]/,"ae", x)
  gsub(/[Ð]/,"D", x)
  gsub(/[ýÿ]/,"y", x)
  gsub(/[ÈÉÊË]/,"E", x)
  gsub(/[ñ]/,"n", x)
  gsub(/[àáâãäå]/,"a", x)
  gsub(/[òóôõöø]/,"o", x)
  gsub(/[ß]/,"b", x)
  gsub(/[ÙÚÛÜ]/,"U", x)
  gsub(/[Þþ]/,"p", x)
  gsub(/[çč]/,"c", x)
  gsub(/[ÌÍÎÏ]/,"I", x)
  gsub(/[ð]/,"d", x)
  gsub(/[èéêë]/,"e", x)
  gsub(/[Æ]/,"Ae", x)
  gsub(/[Ý]/,"Y", x)

  # # for using "agrep -w" there can only be alphanumerics and underscore.
  # # the only key non-punct characters to maintain are "()" and "&"
  # gsub (/[()]/,"_",x)
  # gsub (/(\ and\ |&)/,"_",x)
  # test: if (x ~ /[^A-Za-z0-9_]/) print "Warning: non al-num in x: " x

  gsub (/\ (and|et.?) \ /," \\& ", x)

  # Now delete spaces and periods, and all other punctuation other than ()&×:
  gsub(/[^A-Za-z0-9()&×]/,"", x)
  # [ was gsub(/[ .]/,"", x) ; gsub(/"/,"", x) ]

  # test
  x = tolower(x)
  if (x ~ /[^a-z()&]×/) print "Warning: non 'a-z()&' in x: " x
  return x
}
