module CountryHelper
	
	# Based on i18n_country_select
	# https://github.com/onomojo/i18n_country_select
	def country_translations
		Thread.current[:country_translations] ||= {}
		Thread.current[:country_translations][I18n.locale] ||= begin
		I18nCountrySelect::Countries::COUNTRY_CODES.map do |code|
				translation = I18n.t(code, :scope => :countries, :default => 'missing')
				translation == 'missing' ? nil : [code, translation]
			end.compact.sort_by do |code, translation|
				normalize_translation(translation)
			end
		end
	end

	private
	def normalize_translation(translation)
		UnicodeUtils.canonical_decomposition(translation).split('').select do |c|
			UnicodeUtils.general_category(c) =~ /Letter|Separator|Punctuation|Number/
		end.join
	end
	
end
