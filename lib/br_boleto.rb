# encoding: utf-8
require 'br_boleto/version'
require 'active_model'
require 'active_support/core_ext/class'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object'
require 'active_support/core_ext/string'

require 'br_boleto/string_methods'
require 'br_boleto/validations'

require 'br_boleto/association/have_conta'
require 'br_boleto/association/have_pagador'
require 'br_boleto/association/have_pagamentos'

# Copyright (C) 2015 Bruno M. Mergen <http://duobr.com.br>
#
# @author Bruno Mucelini Mergen <brunomergen@gmail.com>
#
# == Boleto Bancário
#
# Emissão de Boletos Bancários em Ruby. Simples e principalmente, flexível.
#
# Essa biblioteca é baseada em outras <b>ótimas</b> bibliotecas.
# Recomendo analisar muito bem cada solução!
#
# * Novo Gateway de Pagamentos da Locaweb: http://www.locaweb.com.br/produtos/gateway-pagamento.html
# * Brcobranca: https://github.com/kivanio/brcobranca
# * Boleto Php: http://boletophp.com.br
# * Stella Caelum: http://stella.caelum.com.br
# * BoletoBancario: https://github.com/tomas-stefano/boleto_bancario
#
# === Instalação via Rubygems
#
#	gem install br_boleto
#
# === Instalar via Bundler
#
# Coloque no Gemfile:
#
#	gem 'br_boleto'
#
# Depois de colocar no Gemfile:
#
#   bundle install
#
module BrBoleto
	def self.root
		File.expand_path '../..', __FILE__
	end

	I18n.load_path += Dir[BrBoleto.root+'/lib/config'+ '/locales'+'/**'+'/*.{rb,yml}']

	extend ActiveSupport::Autoload
	autoload :ActiveModelBase
	
	module Helper
		extend ActiveSupport::Autoload

		autoload :DefaultCodes
		autoload :CpfCnpj
		autoload :Number
		autoload :FormatValue
	end

	
	autoload :Pagador

	class Configuration
		# Gerador de arquivo de boleto.
		# @return [Symbol]
		# @param  [Symbol] (Padrão: :rghost)
		attr_accessor :gerador
		# Formato do arquivo de boleto a ser gerado.
		# @return [Symbol]
		# @param  [Symbol] (Padrão: :pdf)
		# @see http://wiki.github.com/shairontoledo/rghost/supported-devices-drivers-and-formats Veja mais formatos na documentação do rghost.
		attr_accessor :formato
	
		# Resolução em pixels do arquivo gerado.
		# @return [Integer]
		# @param  [Integer] (Padrão: 150)
		attr_accessor :resolucao
	
		# Ajusta o encoding do texto do boleto enviado para o GhostScript
		# O valor 'ascii-8bit' evita problemas com acentos e cedilha
		# @return [String]
		# @param  [String] (Padrão: nil)
		attr_accessor :external_encoding
	
		# Atribui valores padrões de configuração
		def initialize
		  self.gerador = :rghost
		  self.formato = :pdf
		  self.resolucao = 150
		  self.external_encoding = 'ascii-8bit'
		end
	  end
	
	  # Atribui os valores customizados para as configurações.
	  def self.configuration
		@configuration ||= Configuration.new
	  end
	
	  # Bloco para realizar configurações customizadas.
	  def self.setup
		yield(configuration)
	  end


	module Conta
		extend ActiveSupport::Autoload
		autoload :Base
		autoload :Sicoob
		autoload :Caixa
		autoload :Bradesco
		autoload :Unicred
		autoload :Sicredi
		autoload :Cecred
		autoload :Itau
		autoload :BancoBrasil
		autoload :Santander
	end
	
	module Boleto
		extend ActiveSupport::Autoload

		autoload :Base
		autoload :Sicoob
		autoload :Caixa
		autoload :Bradesco
		autoload :Unicred
		autoload :Sicredi
		autoload :Cecred
		autoload :Itau
		autoload :BancoBrasil
		autoload :Santander

		# Módulos para classes de template
		module Template
			autoload :Base,        'br_boleto/boleto/template/base'
			autoload :Rghost,      'br_boleto/boleto/template/rghost'
			autoload :RghostCarne, 'br_boleto/boleto/template/rghost_carne'
		end
	end


	module Remessa
		extend ActiveSupport::Autoload
		autoload :Base
		autoload :Lote
		autoload :Pagamento

		module Cnab240
			extend ActiveSupport::Autoload
			autoload :Base
			autoload :Sicoob
			autoload :Caixa
			autoload :Bradesco
			autoload :Unicred
			autoload :Sicredi
			autoload :Cecred
			autoload :Itau
			autoload :BancoBrasil
			autoload :Santander
		end
		module Cnab400
			extend ActiveSupport::Autoload
			autoload :Base
			autoload :Sicoob
			autoload :Bradesco
			autoload :Unicred
			autoload :Sicredi
			autoload :Itau
			autoload :BancoBrasil
			autoload :Santander
			autoload :Caixa
		end
	end
	
	module Retorno
		extend ActiveSupport::Autoload
		autoload :Base
		autoload :Pagamento
		module Cnab240
			extend ActiveSupport::Autoload
			autoload :Base
			autoload :Sicoob
			autoload :Caixa
			autoload :Bradesco
			autoload :Unicred
			autoload :Sicredi
			autoload :Cecred
			autoload :Itau
			autoload :BancoBrasil
			autoload :Santander
		end
		module Cnab400
			extend ActiveSupport::Autoload
			autoload :Base
			autoload :Sicoob
			autoload :Bradesco
			autoload :Unicred
			autoload :Sicredi
			autoload :Itau
			autoload :BancoBrasil
			autoload :Santander
			autoload :Caixa
		end
	end

	
	# Módulo que possui classes que realizam os cálculos dos campos que serão mostrados nos boletos.
	#
	module Calculos
		extend ActiveSupport::Autoload

		autoload :FatorVencimento
		autoload :FatoresDeMultiplicacao
		autoload :LinhaDigitavel
		autoload :Modulo10
		autoload :Modulo11
		autoload :Modulo11FatorDe2a9
		autoload :Modulo11Fator3197
		autoload :Modulo11FatorDe2a9RestoZero
		autoload :Modulo11FatorDe2a7
		autoload :Modulo11FatorDe9a2
		autoload :Modulo11FatorDe9a2RestoX
		autoload :ModuloNumeroDeControle
		autoload :Digitos
	end

	include Helper
	include Boleto
	include Remessa
end
