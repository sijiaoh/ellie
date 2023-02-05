shared_examples "has content concern" do
  describe "content escaping" do
    let(:content) { "<script>alert('hi');</script>" }

    before { subject.update! content: }

    context "when editor_type is textarea" do
      before { subject.update! editor_type: :textarea }

      it "does not escape content before save" do
        expect(subject.content).to eq content
      end
    end

    context "when editor_type is wysiwyg" do
      before { subject.update! editor_type: :wysiwyg }

      it "escapes content before save" do
        expect(subject.content).to eq "&lt;script&gt;alert('hi');&lt;/script&gt;"
      end
    end

    context "when editor_type is markdown" do
      before { subject.update! editor_type: :markdown }

      it "does not escape content before save" do
        expect(subject.content).to eq content
      end
    end
  end
end
