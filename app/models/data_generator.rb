class DataGenerator
  include ActiveModel::Model

  attr_accessor :name, :type

  # def name
  #   Faker.const_get(@type).name
  # end

  # def self.getsuperhero
  #   Faker::Superhero.name
  # end

  def self.find(datatype, attrargs)
    # datatype = ["address", "city"] | ["finance", "credit_card"]
    # attrargs  = makati             | mastercard

    classification = datatype.first
    attribute = datatype.last

    faker_constants = Faker.constants
    downcased_constants = faker_constants.map { |v| v.to_s.downcase }
    faker_classification_symbol = faker_constants[downcased_constants.index(classification)]
    
    self.class.send(:attr_accessor, attribute)
    dgList = []
    count = attrargs.key?("count") ? attrargs.fetch("count").to_i : 1
    dg = DataGenerator.new
    c = Faker.const_get(faker_classification_symbol)

    (1..count).each do
      if c.method(attribute).parameters.length > 0 && !attrargs.empty? && attrargs.key?("val")
        dg.instance_variable_set("@#{attribute}", c.send(attribute, attrargs.fetch("val")))
      else
        dg.instance_variable_set("@#{attribute}", c.send(attribute))
      end
      dgList << dg
    end

    puts 'dgList: ' + dgList.to_s
    dgList
  end
end
