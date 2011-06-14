require 'spec_helper'

describe ApplicationHelper do
  describe '#language_options' do
    context 'when the current locale is a supported language' do
      before(:each) do
        I18n.locale = :en
      end

      it 'returns other supported languages' do
        helper.language_options.should include(:de, :nl)
      end

      it 'does not return the current locale' do
        helper.language_options.should_not include(:en)
      end
    end

    context 'when the current locale is not a supported language' do
      before(:each) do
        @orig_locale = I18n.locale
        I18n.locale = :unsupported
      end

      after(:each) do
        I18n.locale = @orig_locale
      end

      it 'returns all supported languages' do
        helper.language_options.should include(:en, :de, :nl)
      end
    end
  end
end
