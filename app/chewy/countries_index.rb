class CountriesIndex < Chewy::Index
  include CommonAnalysisIndex

  define_type ::Country.all do 
    field :name, analyzer: 'english_analyzer', type: :string do
      field :keywordstring, type: :string, analyzer: 'english_analyzer'
      field :edgengram, "type": :string, analyzer: 'edge_ngram_analyzer', search_analyzer: 'edge_ngram_search_analyzer'
      field :completion, "type": 'completion', analyzer: 'english_analyzer', search_analyzer: 'edge_ngram_search_analyzer', preserve_separators: false
    end
    field :code, type: :string
  end

  def self.search_country_code(keyword)
    return [] if keyword.blank?

    result = CountriesIndex.query(bool: {
      "must": {
        'dis_max': {
          'queries': [
            { "multi_match": {  "type": "most_fields",  "query": keyword, "fields": ["name", "name.keywordstring", "name.edgengram"], 'fuzziness': 1 } },
            { "multi_match": { "query": keyword, "type": "phrase_prefix", "fields": ["name"] } }
          ]
        }
      }
    })
    arr = result.map do |r|
      next if r.attributes.blank?

      r.attributes.slice('name', 'code')
    end
    arr.first
  rescue Elasticsearch::Transport::Transport::Errors::InternalServerError,
         Errno::ECONNRESET
    []
  end
end