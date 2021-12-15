class AddSomeIndexes < ActiveRecord::Migration[4.2]
  def up
    # puppetclasses
    add_index :puppetclasses, :name

    # turn off Foreign Key checks
    execute 'SET CONSTRAINTS ALL DEFERRED;' if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'

    add_foreign_key 'host_classes', 'hosts', name: 'host_classes_host_id_fk'
    add_foreign_key 'host_classes', 'puppetclasses', name: 'host_classes_puppetclass_id_fk'
    add_foreign_key 'operatingsystems_puppetclasses', 'operatingsystems', name: 'operatingsystems_puppetclasses_operatingsystem_id_fk'
    add_foreign_key 'operatingsystems_puppetclasses', 'puppetclasses', name: 'operatingsystems_puppetclasses_puppetclass_id_fk'
  end

  def down
    remove_foreign_key('host_classes', 'hosts') if foreign_key_exists?(:host_classes, :hosts)
    remove_foreign_key('host_classes', 'puppetclasses') if foreign_key_exists?(:host_classes, :puppetclasses)
    remove_foreign_key('operatingsystems_puppetclasses', 'operatingsystems') if foreign_key_exists?(:operatingsystems_puppetclasses, :operatingsystems)
    remove_foreign_key('operatingsystems_puppetclasses', 'puppetclasses') if foreign_key_exists?(:operatingsystems_puppetclasses, :puppetclasses)
  end
end
