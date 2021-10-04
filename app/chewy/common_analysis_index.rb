module CommonAnalysisIndex
  extend ActiveSupport::Concern

  included do
    settings analysis: {
      filter: {
        english_stop: {
          type:       'stop',
          stopwords:  '_english_'
        },
        english_stemmer: {
          type:       'stemmer',
          language:   'english'
        }
      },
      analyzer: {
        english_analyzer: {
          tokenizer: 'keyword',
          filter: %w[
            lowercase
            asciifolding
            trim
            english_stop
            english_stemmer
            word_delimiter
          ],
          type: 'custom'
        },
        edge_ngram_analyzer: {
          filter: [
            'lowercase'
          ],
          tokenizer: 'edge_ngram_tokenizer'
        },
        edge_ngram_search_analyzer: {
          "tokenizer": 'lowercase'
        }
      },
      tokenizer: {
        edge_ngram_tokenizer: {
          type: 'edge_ngram',
          min_gram: 2,
          max_gram: 5,
          token_chars: [
            'letter'
          ]
        }
      }
    }
  end
end
