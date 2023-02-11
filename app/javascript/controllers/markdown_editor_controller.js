import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggle", "editor", "viewer"];
  static values = { toggle: String };

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
    if (this.toggleValue == "") this.toggleTarget.classList.add("hidden");
    else this.toggleTarget.classList.remove("hidden");
  }

  toggle() {
    if (this.toggleValue == "") return;

    this.toggleValue = this.toggleValue == "editor" ? "viewer" : "editor";
    this.syncShows();
  }

  syncShows() {
    if (this.toggleValue == "") return;

    if (this.toggleValue == "editor") {
      this.editorTarget.classList.remove("hidden");
      this.viewerTarget.classList.add("hidden");
    } else if (this.toggleValue == "viewer") {
      this.editorTarget.classList.add("hidden");
      this.viewerTarget.classList.remove("hidden");
    }
  }
}
