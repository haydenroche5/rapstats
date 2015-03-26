require 'spec_helper'

module RapGenius
  describe Line, vcr: { cassette_name: "line-2638695" } do

    let(:line) { described_class.find("2638695") }
    subject { line }

    its(:id)       { should eq "2638695" }
    its(:song)     { should be_a Song }
    its(:lyric) { should eq "Versace, Versace, Medusa head on me like I'm 'luminati" }
    its("explanations.first") { should include "Versace’s logo is the head of Medusa" }
    its(:explanations) { should eq line.annotations }

    context "a non-existent referent ID" do
      let(:line) { described_class.find("bahahaha") }

      it "raises an exception" do
        expect { line }.to raise_exception
      end
    end
  end
end
