Elasticsearch::Model.client = Elasticsearch::Client.new url: APP_CONFIG['ELASTICSEARCH_URL']

unless Message.__elasticsearch__.index_exists?
    Message.__elasticsearch__.create_index! force: true
    Message.import batch_size: 100
    Message.__elasticsearch__.refresh_index!
end