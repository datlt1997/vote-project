

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["fileInput", "form"];

  connect() {
     console.log("OptionController connected");
  }
  
  triggerFileSelect(event) {
    event.preventDefault();
    this.fileInputTarget.click();
  }

  submitForm() {
    console.log(1111);
    if (this.fileInputTarget.files.length > 0) {
      console.log("Submit!");
      this.formTarget.submit();
    }
  }
}