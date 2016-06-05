#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

by_cat = WikiData::Category.new( 'Categoria:Senatori della XVII Legislatura della Repubblica Italiana', 'it').member_titles

EveryPolitician::Wikidata.scrape_wikidata(names: { it: by_cat }, batch_size: 100)
