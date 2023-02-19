import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleButton", "editor", "viewer"];
  static values = { toggleMode: String };

  updateViewerContent(event) {
    const viewerController =
      this.application.getControllerForElementAndIdentifier(
        this.viewerTarget,
        "markdown-viewer"
      );
    if (viewerController == null) return;

    this.syncButtonShow();
    this.syncShows();

    viewerController.updateContent(event.detail.text);
  }

  syncButtonShow() {
    if (this.toggleModeValue == "") this.hideElement(this.toggleButtonTarget);
    else this.showElement(this.toggleButtonTarget);
  }

  toggle() {
    if (this.toggleModeValue == "") return;

    this.toggleModeValue =
      this.toggleModeValue == "editor" ? "viewer" : "editor";
    this.syncShows();
  }

  syncShows() {
    if (this.toggleModeValue == "") return;

    if (this.toggleModeValue == "editor") {
      this.showElement(this.editorTarget);
      this.hideElement(this.viewerTarget);
    } else if (this.toggleModeValue == "viewer") {
      this.hideElement(this.editorTarget);
      this.showElement(this.viewerTarget);
    }
  }

  showElement(element) {
    element.classList.remove("hidden");
  }

  hideElement(element) {
    element.classList.add("hidden");
  }
}
