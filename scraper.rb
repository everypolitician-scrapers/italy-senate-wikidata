#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

by_cat = WikiData::Category.new( 'Categoria:Senatori della XVII legislatura della Repubblica Italiana', 'it').member_titles |
         WikiData::Category.new( 'Categoria:Senatori della XVIII legislatura della Repubblica Italiana', 'it').member_titles

# Senators of the 17th/18th Legislature
sparq = <<EOQ
  SELECT DISTINCT ?item WHERE {
    VALUES ?term { wd:Q5487948 wd:Q48799610 }
    ?item p:P39 [ ps:P39 wd:Q13653224 ; pq:P2937 ?term ]
  }
EOQ
ids = EveryPolitician::Wikidata.sparql(sparq)

# Senators for life
# TODO: if this list gets too big, restrict by date (or date of death)
life_sparq = 'SELECT DISTINCT ?item WHERE { ?item p:P39/ps:P39 wd:Q826589 }'
life_ids = EveryPolitician::Wikidata.sparql(life_sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids | life_ids, names: { it: by_cat })
