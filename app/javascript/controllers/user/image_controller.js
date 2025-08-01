import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput"]

  triggerFileDialog(event) {
    event.preventDefault()
    this.fileInputTarget.click()
    console.log("click!")
  }
}
