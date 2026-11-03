module Coolbelt::AttributesFrom
  extend ActiveSupport::Concern

  class_methods do
    def attributes_from(name, &block)
      attributes_from_x = "attributes_from_#{name}".to_sym
      attributes_from_x_proc = "#{attributes_from_x}_proc".to_sym
      set_attributes_from = "set_#{attributes_from_x}"

      define_method("#{name}=") do |value|
        super(value)
        send(set_attributes_from)
      end

      # attributes_from_X_proc
      class_attribute(attributes_from_x_proc)
      send("#{attributes_from_x_proc}=", block)

      # attributes_from_X=
      define_method("#{attributes_from_x}=") do |data|
        assign_attributes(send(attributes_from_x_proc).call(data))
      end

      # set_attributes_from_X
      define_method(set_attributes_from) do
        public_send("#{attributes_from_x}=", public_send(name))
      end

      # attributes_from_X!
      define_method("#{attributes_from_x}!") do
        send(set_attributes_from)
        save!
      end

      # self.attributes_from_X
      define_singleton_method(attributes_from_x) do |data|
        send(attributes_from_x_proc).call(data)
      end

      # self.update_all_attributes_from_X
      define_singleton_method("update_all_#{attributes_from_x}") do
        find_each(&"#{attributes_from_x}!".to_sym)
      end
    end
  end
end
