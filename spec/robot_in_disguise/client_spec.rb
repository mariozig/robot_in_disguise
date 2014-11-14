require 'spec_helper'

describe RobotInDisguise::Client, :vcr do
  describe '#initialize' do
    context 'when invalid headers are provided' do
      it 'raises a ConfigurationError exception' do
        expect { RobotInDisguise::Client.new(company_id: 4747) }.to raise_exception(RobotInDisguise::Error::ConfigurationError)
      end
    end

    context 'when auth details are missing' do
      it 'raises an exception against `app_id`' do
        expect { RobotInDisguise::Client.new(app_secret: 'secret') }.to raise_exception(RobotInDisguise::Error::ConfigurationError)
      end

      it 'raises an exception against `app_secret`' do
        expect { RobotInDisguise::Client.new(app_id: 'secret') }.to raise_exception(RobotInDisguise::Error::ConfigurationError)
      end
    end
  end
end
