module Api::V1
  class DataGeneratorController < ApiController
    before_action :set_data_generator, only: [:show]

    def show
      puts '-----------------------'
      puts request.original_fullpath
      puts request.path[1..-1]
      puts @datagenerator
      puts '-----------------------'

      json_response(@datagenerator)
    end

    private

      # def data_generator_params
      #   params.permit()
      # end

      def set_data_generator
        qindex = 0
        attrargs = {}
        path = request.fullpath
        if path.include?("?")
          qindex = path.index("?")
          puts 'path[qindex + 1..-1]: ' + path[qindex + 1..-1]
          # attrargs  = path[qindex + 1..-1].split("=").last
          attrargs = path[qindex + 1..-1].split("&").map { |a| a.split("=") }.to_h
        end
        datatype = path[1..qindex - 1].split("/")
        datatype.shift(2)

        puts '---------------------------'
        puts 'params: ' + params.to_s
        puts 'request.path: ' + request.path
        puts 'request.fullpath: ' + request.fullpath
        puts 'qindex: ' + qindex.to_s
        puts 'datatype: ' + datatype.to_s
        puts 'attrargs: ' + attrargs.to_s
        @datagenerator = DataGenerator.find(datatype, attrargs)
      end
  end
end