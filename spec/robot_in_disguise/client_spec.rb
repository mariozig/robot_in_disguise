require 'spec_helper'

describe RobotInDisguise::Client, :vcr do
  describe '#initialize' do
    context 'when invalid headers are provided' do
      it 'raises a ConfigurationError exception' do
        expect { RobotInDisguise::Client.new(company_id: 4747) }.to raise_exception(RobotInDisguise::Error::ConfigurationError)
      end
    end

    context 'when no headers are provided' do
      it 'does not raise an exception' do
        expect { RobotInDisguise::Client.new }.not_to raise_error
      end
    end
  end
end
