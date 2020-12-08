module BrBoleto
	module Helper
        class FormatData 
            # Mostra a data em formato <b>dia/mês/ano</b>
            # @return [String]
            # @example
            #  Date.current.to_s_br #=> 20/01/2010
            def to_s_br
                strftime('%d/%m/%Y')
            end
        end
    end
end