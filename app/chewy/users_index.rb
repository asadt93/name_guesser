class UsersIndex < Chewy::Index
  include CommonAnalysisIndex

  define_type ::User.all do 
    field :name, analyzer: 'english_analyzer', type: :string do
      field :keywordstring, type: :string, analyzer: 'english_analyzer'
      field :edgengram, "type": :string, analyzer: 'edge_ngram_analyzer', search_analyzer: 'edge_ngram_search_analyzer'
      field :completion, "type": 'completion', analyzer: 'english_analyzer', search_analyzer: 'edge_ngram_search_analyzer', preserve_separators: false
    end
    field :country_name, type: :string
  end

  def self.search_country_by_name(keyword)
    return [] if keyword.blank?

    result = UsersIndex.query(bool: {
      "must": {
        'dis_max': {
          'queries': [
            { "multi_match": {  "type": "most_fields",  "query": keyword, "fields": ["name", "name.keywordstring", "name.edgengram"], 'fuzziness': 1 } },
            { "multi_match": { "query": keyword, "type": "phrase_prefix", "fields": ["name"] } }
          ]
        }
      }
    })
    
    arr = result.map{|r| r.attributes.slice('name', 'country_name') }
    arr.group_by{|a| a['country_name']}.keys
  rescue Elasticsearch::Transport::Transport::Errors::InternalServerError,
         Errno::ECONNRESET
    []
  end
end