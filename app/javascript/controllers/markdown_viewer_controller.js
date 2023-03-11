import { Controller } from "@hotwired/stimulus";
import { marked } from "marked";
import DOMPurify from "dompurify";

export default class extends Controller {
  static targets = ["content"];
  static values = { content: String };

  contentValueChanged() {
    this.contentTarget.innerHTML = DOMPurify.sanitize(
      marked(this.contentValue, { breaks: true })
    );
    window.Prism.highlightAllUnder(this.contentTarget);
  }

  updateContent(text) {
    this.contentValue = text;
  }
}
