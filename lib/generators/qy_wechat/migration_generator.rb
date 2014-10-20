require 'rails/generators/active_record'

module QyWechat
  module Generators
    class MigrationGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Adds a qy qy_token, encoding_aes_key, corp_id for your application.'
      def create_migration_file
        if !migration_exists?(table_name)
          migration_template "add_qy_wechat_columns.rb", "db/migrate/add_qy_wechat_columns_to_#{plural_name}.rb"
        end
      end

      private

      def model_exists?
        File.exists?(File.join(destination_root, model_path))
      end

      def model_path
        @model_path ||= File.join("app", "models", "#{file_path}.rb")
      end

      def migration_exists?(table_name)
        Dir.glob("#{File.join(destination_root, migration_path)}/[0-9]*_*.rb").grep(/\d+_add_qy_wechat_columns_to_#{table_name}.rb/).first
      end

      def migration_path
        @migration_path ||= File.join("db", "migrate")
      end

    end
  end
end
