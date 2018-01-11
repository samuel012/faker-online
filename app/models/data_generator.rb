class DataGenerator
  include ActiveModel::Model

  attr_accessor :name, :type

  # def name
  #   Faker.const_get(@type).name
  # end

  # def self.getsuperhero
  #   Faker::Superhero.name
  # end

  def self.find(datatype, attrarg)
    # datatype = ["address", "city"] | ["finance", "credit_card"]
    # attrarg  = makati              | mastercard

    classification = datatype.first
    attribute = datatype.last

    faker_constants = Faker.constants
    downcased_constants = faker_constants.map { |v| v.to_s.downcase }
    faker_classification_symbol = faker_constants[downcased_constants.index(classification)]
    
    self.class.send(:attr_accessor, attribute)
    dg = DataGenerator.new

    c = Faker.const_get(faker_classification_symbol)
    # puts '------------------------'
    # puts 'classification: ' + classification
    # puts 'attribute: ' + attribute
    # puts 'attrarg: ' + attrarg
    if c.method(attribute).parameters.length > 0 && attrarg != ""
      dg.instance_variable_set("@#{attribute}", c.send(attribute, attrarg))
    else
      dg.instance_variable_set("@#{attribute}", c.send(attribute))
    end
    dg
  end

  def permitted_params
    
  end
end
