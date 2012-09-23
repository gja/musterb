describe Musterb::Evaluator do
  it "can pull local variables out from the binding" do
    foo = "bar"
    evaluator = Musterb::Evaluator.new Musterb::BindingExtractor.new(binding, nil)
    evaluator["foo"].should eq "bar"
  end

  it "pulls out values from ." do
    evaluator = Musterb::Evaluator.new Musterb::ObjectExtractor.new(2, nil)
    evaluator.value.should eq 2
  end

  it "can do nested values" do
    evaluator = Musterb::Evaluator.new Musterb::ObjectExtractor.new(2, nil)
    evaluator.chain("next")["to_s"].should eq "3"
  end

  it "can deeply nest things" do
    evaluator = Musterb::Evaluator.new Musterb::ObjectExtractor.new(2, nil)
    evaluator.chain("next").chain("next")["to_s"].should eq "4"
  end

  it "does not barf when pulling out a value on nil" do
    evaluator = Musterb::Evaluator.new Musterb::HashExtractor.new({:foo => nil}, nil)
    evaluator.chain("foo")["bar"].should eq nil
  end

  context "block" do
    let(:evaluator) { Musterb::Evaluator.new Musterb::NullExtractor.new(nil) }

    it "yields to the block if a value is set" do          
      expect { |b| evaluator.block_if("bar", &b) }.to yield_control
    end

    it "does not yield to the block if the value is unset" do
      expect { |b| evaluator.block_if(nil, &b) }.not_to yield_control
    end

    it "yields to the block for every element in the array" do
      expect { |b| evaluator.block_if([1,2,3], &b) }.to yield_successive_args(1,2,3)
    end

    it "does not yield to an empty array" do
      expect { |b| evaluator.block_if([], &b) }.not_to yield_control
    end

    it "yields to an empty hash" do
      expect { |b| evaluator.block_if({}, &b) }.to yield_control
    end
  end

  context "block_unless" do
    let(:evaluator) { Musterb::Evaluator.new Musterb::NullExtractor.new(nil) }

    it "does not yield to the block if a value is set" do          
      expect { |b| evaluator.block_unless("bar", &b) }.not_to yield_control
    end

    it "does not yield to the block if the value is unset" do
      expect { |b| evaluator.block_unless(nil, &b) }.to yield_control
    end

    it "yields to the block for every element in the array" do
      expect { |b| evaluator.block_unless([1, 2, 3], &b) }.not_to yield_control
    end

    it "does not yield to an empty array" do    
      expect { |b| evaluator.block_unless([], &b) }.to yield_control
    end
  end

  context "switching context" do
    it "switches inside a hash" do
      hash = { "foo" => "bar"}    
      evaluator = Musterb::Evaluator.new Musterb::BindingExtractor.new(binding, nil)
      evaluator.block_if hash do
        evaluator['foo'].should eq 'bar'
      end
    end

    it "resets the context later" do
      hash = { "foo" => "bar"}
      evaluator = Musterb::Evaluator.new Musterb::BindingExtractor.new(binding, nil)
      evaluator.block_if(hash) {}
      evaluator["hash"].should eq hash
    end

    it "cascades the context to the parent" do
      foo = "bar"
      hash = { }
      evaluator = Musterb::Evaluator.new Musterb::BindingExtractor.new(binding, nil)
      evaluator.block_if hash do
        evaluator['foo'].should eq 'bar'
      end
    end
  end
end