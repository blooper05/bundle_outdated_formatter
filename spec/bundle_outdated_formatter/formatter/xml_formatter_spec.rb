RSpec.describe BundleOutdatedFormatter::XMLFormatter do
  let(:pretty) { false }
  let(:formatter) { described_class.new(pretty: pretty) }

  let(:outdated_gems) do
    [
      {
        'gem'       => 'faker',
        'newest'    => '1.6.6',
        'installed' => '1.6.5',
        'requested' => '~> 1.4',
        'groups'    => 'development, test'
      },
      {
        'gem'       => 'hashie',
        'newest'    => '3.4.6',
        'installed' => '1.2.0',
        'requested' => '= 1.2.0',
        'groups'    => 'default'
      },
      {
        'gem'       => 'headless',
        'newest'    => '2.3.1',
        'installed' => '2.2.3',
        'requested' => '',
        'groups'    => ''
      }
    ]
  end

  let(:text_xml) do
    <<-EOS.chomp
<?xml version='1.0' encoding='UTF-8'?><gems><outdated><gem>faker</gem><newest>1.6.6</newest><installed>1.6.5</installed><requested>~> 1.4</requested><groups>development, test</groups></outdated><outdated><gem>hashie</gem><newest>3.4.6</newest><installed>1.2.0</installed><requested>= 1.2.0</requested><groups>default</groups></outdated><outdated><gem>headless</gem><newest>2.3.1</newest><installed>2.2.3</installed><requested></requested><groups></groups></outdated></gems>
    EOS
  end

  let(:text_xml_pretty) do
    <<-EOS.chomp
<?xml version='1.0' encoding='UTF-8'?>
<gems>
  <outdated>
    <gem>faker</gem>
    <newest>1.6.6</newest>
    <installed>1.6.5</installed>
    <requested>~> 1.4</requested>
    <groups>development, test</groups>
  </outdated>
  <outdated>
    <gem>hashie</gem>
    <newest>3.4.6</newest>
    <installed>1.2.0</installed>
    <requested>= 1.2.0</requested>
    <groups>default</groups>
  </outdated>
  <outdated>
    <gem>headless</gem>
    <newest>2.3.1</newest>
    <installed>2.2.3</installed>
    <requested></requested>
    <groups></groups>
  </outdated>
</gems>
    EOS
  end

  describe '#convert' do
    before do
      formatter.instance_variable_set(:@outdated_gems, outdated_gems)
    end

    subject { formatter.convert }

    context 'when @pretty is false' do
      it { is_expected.to eq text_xml }
    end

    context 'when @pretty is true' do
      let(:pretty) { true }
      it { is_expected.to eq text_xml_pretty }
    end
  end
end
