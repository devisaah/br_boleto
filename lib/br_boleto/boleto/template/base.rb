# -*- encoding: utf-8 -*-
#

module BrBoleto
  module Boleto
    module Template
      module Base
        extend self

        def define_template(template)
          case template
          when :rghost
            [BrBoleto::Boleto::Template::Rghost]
          when :rghost_carne
            [BrBoleto::Boleto::Template::RghostCarne]
          when :both
            [BrBoleto::Boleto::Template::Rghost, BrBoleto::Boleto::Template::RghostCarne]
          else
            [BrBoleto::Boleto::Template::Rghost]
          end
        end
      end
    end
  end
end
