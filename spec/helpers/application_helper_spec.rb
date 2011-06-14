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

  describe '.sex_info' do
    before(:each) do
      @dog = Dog.new
    end

    context 'for a neutered' do
      before(:each) do
        @dog.neutered = true
      end

      context 'dog' do
        before(:each) do
          @dog.female = false
        end

        it 'is a neutered male' do
          info = helper.sex_info(@dog)
          info.should match /^#{Regexp.escape t('db.dog.male')}/
          info.should match /#{Regexp.escape t('db.dog.neutered')}$/
        end
      end

      context 'bitch' do
        before(:each) do
          @dog.female = true
        end

        it 'is a spayed female' do
          info = helper.sex_info(@dog)
          info.should match /^#{Regexp.escape t('db.dog.female')}/
          info.should match /#{Regexp.escape t('db.dog.spayed')}$/
        end
      end
    end

    context 'for an intact' do
      before(:each) do
        @dog.neutered = false
      end

      context 'dog' do
        before(:each) do
          @dog.female = false
        end

        it 'is male' do
          info = helper.sex_info(@dog)
          info.should     match /^#{Regexp.escape t('db.dog.male')}/
          info.should_not match /#{Regexp.escape t('db.dog.neutered')}$/
        end
      end

      context 'bitch' do
        before(:each) do
          @dog.female = true
        end

        it 'is female' do
          info = helper.sex_info(@dog)
          info.should     match /^#{Regexp.escape t('db.dog.female')}/
          info.should_not match /#{Regexp.escape t('db.dog.spayed')}$/
        end
      end
    end
  end

  describe '.state_options' do
    it 'is an array of arrays' do
      states = helper.state_options
      states.should be_an Array
      states.detect{|opt| !opt.is_a? Array}.should be_nil
    end
  end

  describe '.country_options' do
    it 'is an array of arrays' do
      countries = helper.country_options
      countries.should be_an Array
      countries.detect{|opt| !opt.is_a? Array}.should be_nil
    end
  end
end
