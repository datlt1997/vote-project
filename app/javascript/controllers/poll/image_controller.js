import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "preview", "removeBtn"]
  static values = {
    initialUrl: String
  }

  triggerFileDialog() {
    console.log(12);
    this.fileInputTarget.click()
  }

  preview(event) {
    const file = event.target.files[0]
    if (!file) return

    const reader = new FileReader()
    reader.onload = (e) => {
      this.previewTarget.src = e.target.result
      this.previewTarget.hidden = false
      this.removeBtnTarget.hidden = false
    }
    reader.readAsDataURL(file)
  }

  removeImage() {
    // Clear file input
    this.fileInputTarget.value = ""

    // Hide preview
    this.previewTarget.src = ""
    this.previewTarget.hidden = true
    this.removeBtnTarget.hidden = true

    // Set hidden flag
    const flagInput = document.getElementById("remove-image-flag")
    if (flagInput) {
      flagInput.value = "true"
    }
  }
}
